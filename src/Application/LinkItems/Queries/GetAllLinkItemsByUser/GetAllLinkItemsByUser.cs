using Socials.Application.Common.Interfaces;
using Socials.Application.Common.Mappings;
using Socials.Application.Common.Models;

namespace Socials.Application.LinkItems.Queries.GetAllLinkItemsByUser;

public record GetAllLinkItemsByUserQuery : IRequest<List<LinkItemBriefDto>>
{
    public string UserId { get; init; }
}

public class GetAllLinkItemsByUserQueryHandler(IApplicationDbContext context, IMapper mapper) : IRequestHandler<GetAllLinkItemsByUserQuery, List<LinkItemBriefDto>>
{
    public async Task<List<LinkItemBriefDto>> Handle(GetAllLinkItemsByUserQuery request, CancellationToken cancellationToken)
    {
        return await _context.LinkItems
            .Where(x => x.UserId == request.UserId)
            .OrderBy(x => x.Order)
            .ProjectTo<LinkItemBriefDto>(mapper.ConfigurationProvider)
            .ToListAsync();
    }
}
