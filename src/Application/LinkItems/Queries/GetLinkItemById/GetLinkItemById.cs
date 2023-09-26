using Socials.Application.Common.Interfaces;
using Socials.Application.Common.Mappings;
using Socials.Application.Common.Models;

namespace Socials.Application.LinkItems.Queries.GetLinkItemById;

public record GetLinkItemByIdQuery : IRequest<LinkItemBriefDto>
{
    public int Id { get; init }
}

public class GetLinkItemByIdQueryHandler(IApplicationDbContext context, IMapper mapper) : IRequestHandler<GetLinkItemByIdQuery, LinkItemBriefDto>
{
    public async Task<LinkItemBriefDto> Handle(GetLinkItemByIdQuery request, CancellationToken cancellationToken)
    {
        return await _context.LinkItems
            .Where(x => x.Id == request.Id)
            .ProjectTo<LinkItemBriefDto>(mapper.ConfigurationProvider)
            .FirstOrDefaultAsync();
    }
}
