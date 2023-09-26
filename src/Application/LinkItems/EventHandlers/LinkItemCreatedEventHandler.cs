using Socials.Domain.Events;
using Microsoft.Extensions.Logging;

namespace Socials.Application.LinkItems.EventHandlers;

public class LinkItemCreatedEventHandler : INotificationHandler<LinkItemCreatedEvent>
{
    private readonly ILogger<LinkItemCreatedEventHandler> _logger;

    public LinkItemCreatedEventHandler(ILogger<LinkItemCreatedEventHandler> logger)
    {
        _logger = logger;
    }

    public Task Handle(LinkItemCreatedEvent notification, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Socials Domain Event: {DomainEvent}", notification.GetType().Name);

        return Task.CompletedTask;
    }
}
