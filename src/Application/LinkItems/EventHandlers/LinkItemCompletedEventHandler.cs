using Socials.Domain.Events;
using Microsoft.Extensions.Logging;

namespace Socials.Application.LinkItems.EventHandlers;

public class LinkItemCompletedEventHandler : INotificationHandler<LinkItemCompletedEvent>
{
    private readonly ILogger<LinkItemCompletedEventHandler> _logger;

    public LinkItemCompletedEventHandler(ILogger<LinkItemCompletedEventHandler> logger)
    {
        _logger = logger;
    }

    public Task Handle(LinkItemCompletedEvent notification, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Socials Domain Event: {DomainEvent}", notification.GetType().Name);

        return Task.CompletedTask;
    }
}
