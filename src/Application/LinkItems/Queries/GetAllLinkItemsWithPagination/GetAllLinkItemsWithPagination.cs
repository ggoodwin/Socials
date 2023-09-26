using Socials.Application.Common.Interfaces;
using Socials.Application.Common.Mappings;
using Socials.Application.Common.Models;

namespace Socials.Application.LinkItems.Queries.GetAllLinkItemsWithPagination;

public record GetAllLinkItemsWithPaginationQuery : IRequest<PaginatedList<LinkItemBriefDto>>
{
    public int PageNumber { get; init; } = 1;
    public int PageSize { get; init; } = 10;
}

public class GetAllLinkItemsWithPaginationQueryHandler(IApplicationDbContext context, IMapper mapper) : IRequestHandler<GetAllLinkItemsWithPaginationQuery, PaginatedList<LinkItemBriefDto>>
{
    public async Task<PaginatedList<LinkItemBriefDto>> Handle(GetAllLinkItemsWithPaginationQuery request, CancellationToken cancellationToken)
    {
        return await _context.LinkItems
            .OrderBy(x => x.Id)
            .ProjectTo<LinkItemBriefDto>(mapper.ConfigurationProvider)
            .PaginatedListAsync(request.PageNumber, request.PageSize);
    }
}

