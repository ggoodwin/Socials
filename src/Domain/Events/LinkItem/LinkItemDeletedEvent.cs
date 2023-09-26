namespace Socials.Domain.Events;

public class LinkItemDeletedEvent : BaseEvent
{
    public LinkItemDeletedEvent(LinkItem item)
    {
        Item = item;
    }

    public LinkItem Item { get; }
}
