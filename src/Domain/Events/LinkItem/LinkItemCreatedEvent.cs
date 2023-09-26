namespace Socials.Domain.Events;

public class LinkItemCreatedEvent : BaseEvent
{
    public LinkItemCreatedEvent(LinkItem item)
    {
        Item = item;
    }

    public LinkItem Item { get; }
}
