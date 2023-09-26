namespace Socials.Domain.Events;

public class LinkItemCompletedEvent : BaseEvent
{
    public LinkItemCompletedEvent(LinkItem item)
    {
        Item = item;
    }

    public LinkItem Item { get; }
}
