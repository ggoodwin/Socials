namespace Socials.Domain.Entities;

public class LinkItem : BaseAuditableEntity
{
    public int Id { get; set; }
    public string Title { get; set; }
    public string Url { get; set; }
    public string Favicon { get; set; }
    public string UserId { get; set; }
}
