using System.Collections.Generic;
using System.Reflection;
using Socials.Application.Common.Exceptions;
using Socials.Application.Common.Interfaces;
using Socials.Application.Common.Security;

namespace Socials.Application.Common.Behaviors;

public class AuthorizationBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse> where TRequest : notnull
{
    private readonly IUser _user;
    private readonly IIdentityService _identityService;

    private AuthorizationBehavior(
        IUser user,
        IIdentityService identityService)
    {
        _user = user;
        _identityService = identityService;
    }

    public static AuthorizationBehavior<TRequest, TResponse> CreateInstance(IUser user, IIdentityService identityService)
    {
        return new AuthorizationBehavior<TRequest, TResponse>(user, identityService);
    }

    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
    {
        var authorizeAttributes = request.GetType().GetCustomAttributes<AuthorizeAttribute>();

        var attributes = authorizeAttributes.ToList();
        if (attributes.Count == 0)
        {
            return await next().ConfigureAwait(false);
        }

        // Must be authenticated user
        if (_user.Id == null)
        {
            throw new UnauthorizedAccessException();
        }

        // Role-based authorization
        var authorizeAttributesWithRoles = attributes.Where(a => !string.IsNullOrWhiteSpace(a.Roles));

        var attributesWithRoles = authorizeAttributesWithRoles.ToList();
        if (attributesWithRoles.Count != 0)
        {
            var authorized = false;

            foreach (var roles in attributesWithRoles.Select(a => a.Roles.Split(',')))
            {
                foreach (var role in roles)
                {
                    var isInRole = await _identityService.IsInRoleAsync(_user.Id, role.Trim());
                    if (!isInRole)
                    {
                        continue;
                    }

                    authorized = true;
                    break;
                }
            }

            // Must be a member of at least one role in roles
            if (!authorized)
            {
                throw new ForbiddenAccessException();
            }
        }

        // Policy-based authorization
        var authorizeAttributesWithPolicies = attributes.Where(a => !string.IsNullOrWhiteSpace(a.Policy));
        var attributesWithPolicies = authorizeAttributesWithPolicies.ToList();
        if (attributesWithPolicies.Count == 0)
        {
            return await next().ConfigureAwait(false);
        }

        {
            foreach (var policy in attributesWithPolicies.Select(a => a.Policy))
            {
                var authorized = await _identityService.AuthorizeAsync(_user.Id, policy);

                if (!authorized)
                {
                    throw new ForbiddenAccessException();
                }
            }
        }

        // User is authorized / authorization not required
        return await next().ConfigureAwait(false);
    }
}
