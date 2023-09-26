using Socials.Application.TodoItems.Commands.CreateTodoItem;
using Socials.Application.TodoItems.Commands.DeleteTodoItem;
using Socials.Application.TodoLists.Commands.CreateTodoList;
using Socials.Domain.Entities;

namespace Socials.Application.FunctionalTests.LinkItems.Commands;

using static Testing;

public class DeleteLinkItemTests : BaseTestFixture
{
    [Test]
    public async Task ShouldRequireValidLinkItemId()
    {
        var command = new DeleteLinkItemCommand(99);

        await FluentActions.Invoking(() =>
            SendAsync(command)).Should().ThrowAsync<NotFoundException>();
    }

    [Test]
    public async Task ShouldDeleteLinkItem()
    {

        var itemId = await SendAsync(new CreateLinkItemCommand
        {
            Name = "New Item"
        });

        await SendAsync(new DeleteLinkItemCommand(itemId));

        var item = await FindAsync<LinkItem>(itemId);

        item.Should().BeNull();
    }
}

