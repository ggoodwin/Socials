using Socials.Application.Common.Interfaces;

namespace Socials.Application.LinkItems.Commands.UpdateLinkItem;

public record UpdateLinkItemCommand : IRequest
{
    public int Id { get; init; }
    public string? Title { get; init; }
    public string? Url { get; init; }
    public string? Favicon { get; init; }
}

public class UpdateLinkItemCommandHandler(IApplicationDbContext context) : IRequestHandler<UpdateLinkItemCommand>
{
    public async Task Handle(UpdateLinkItemCommand request, CancellationToken cancellationToken)
    {
        var entity = await context.LinkItems
            .FindAsync(new object[] { request.Id }, cancellationToken);

        Guard.Against.NotFound(request.Id, entity);

        entity.Title = request.Title;
        entity.Url = request.Url;
        entity.Favicon = request.Favicon;

        await context.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
    }
}
