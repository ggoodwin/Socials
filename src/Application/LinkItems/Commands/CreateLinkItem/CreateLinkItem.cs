using Socials.Application.Common.Interfaces;
using Socials.Domain.Entities;
using Socials.Domain.Events;

namespace Socials.Application.LinkItems.Commands.CreateLinkItem;

public record CreateLinkItemCommand : IRequest<int>
{
    public string? Title { get; init; }
    public string? Url { get; init; }
    public string? Favicon { get; init; }
    public string? UserId { get; init; }
}

public class CreateLinkItemCommandHandler(IApplicationDbContext context) : IRequestHandler<CreateLinkItemCommand, int>
{
    public async Task<int> Handle(CreateLinkItemCommand request, CancellationToken cancellationToken)
    {
        var entity = new LinkItem
        {
            Title = request.Title,
            Url = request.Url,
            Favicon = request.Favicon,
            UserId = request.UserId
        };

        entity.AddDomainEvent(new LinkItemCreatedEvent(entity));

        context.LinkItems.Add(entity);

        await context.SaveChangesAsync(cancellationToken);

        return entity.Id;
    }
}
