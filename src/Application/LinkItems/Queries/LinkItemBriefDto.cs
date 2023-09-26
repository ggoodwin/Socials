using Socials.Domain.Entities;

namespace Socials.Application.LinkItems.Queries;

public class LinkItemBriefDto
{
    public int Id { get; init; }
    public string? Title { get; init; }
    public string? Url { get; init; }
    public string? Favicon { get; init; }
    public string? UserId { get; init; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<LinkItem, LinkItemBriefDto>();
        }
    }
}
