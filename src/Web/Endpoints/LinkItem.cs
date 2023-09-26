using Socials.Application.Common.Models;
using Socials.Application.TodoItems.Commands.CreateTodoItem;
using Socials.Application.TodoItems.Commands.DeleteTodoItem;
using Socials.Application.TodoItems.Commands.UpdateTodoItem;
using Socials.Application.TodoItems.Commands.UpdateTodoItemDetail;
using Socials.Application.TodoItems.Queries.GetTodoItemsWithPagination;

namespace Socials.Web.Endpoints;

public class LinkItems : EndpointGroupBase
{
    public override void Map(WebApplication app)
    {
        app.MapGroup(this)
            .RequireAuthorization()
            .MapGet(GetAllLinkItemsByUser, "{UserId}")
            .MapGet(GetAllLinkItemsWithPagination)
            .MapGet(GetLinkItemById, "{id}")
            .MapPost(CreateLinkItem)
            .MapPut(UpdateLinkItem, "{id}")
            .MapDelete(DeleteLinkItem, "{id}");
    }

    public async Task<PaginatedList<LinkItemBriefDto>> GetAllLinkItemsWithPagination(ISender sender, [AsParameters] GetAllLinkItemsWithPaginationQuery query)
    {
        return await sender.Send(query);
    }

    public async Task<List<LinkItemBriefDto>> GetAllLinkItemsByUser(ISender sender, string UserId, [AsParameters] GetAllLinkItemsByUserQuery query)
    {
        return await sender.Send(query);
    }

    public async Task<LinkItemBriefDto> GetLinkItemById(ISender sender, int id, [AsParameters] GetLinkItemByIdQuery query)
    {
        return await sender.Send(query);
    }

    public async Task<int> CreateLinkItem(ISender sender, CreateLinkItemCommand command)
    {
        return await sender.Send(command);
    }

    public async Task<IResult> UpdateLinkItem(ISender sender, int id, UpdateLinkItemCommand command)
    {
        if (id != command.Id) return Results.BadRequest();
        await sender.Send(command);
        return Results.NoContent();
    }

    public async Task<IResult> DeleteLinkItem(ISender sender, int id)
    {
        await sender.Send(new DeleteLinkItemCommand(id));
        return Results.NoContent();
    }
}
