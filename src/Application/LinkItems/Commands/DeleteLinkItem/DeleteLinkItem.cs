using Socials.Application.Common.Interfaces;
using Socials.Domain.Events;

namespace Socials.Application.LinkItems.Commands.DeleteLinkItem;

public record DeleteLinkItemCommand(int Id) : IRequest;

public class DeleteLinkItemCommandHandler(IApplicationDbContext context) : IRequestHandler<DeleteLinkItemCommand>
{
    public async Task Handle(DeleteLinkItemCommand request, CancellationToken cancellationToken)
    {
        var entity = await context.LinkItems
            .FindAsync(new object[] { request.Id }, cancellationToken);

        Guard.Against.NotFound(request.Id, entity);

        context.LinkItems.Remove(entity);

        entity.AddDomainEvent(new LinkItemDeletedEvent(entity));

        await context.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
    }
}
