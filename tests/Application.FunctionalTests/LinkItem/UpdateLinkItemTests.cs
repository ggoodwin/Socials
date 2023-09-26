using Socials.Application.TodoItems.Commands.CreateTodoItem;
using Socials.Application.TodoItems.Commands.UpdateTodoItem;
using Socials.Application.TodoLists.Commands.CreateTodoList;
using Socials.Domain.Entities;

namespace Socials.Application.FunctionalTests.LinkItems.Commands;

using static Testing;

public class UpdateLinkItemTests : BaseTestFixture
{
    [Test]
    public async Task ShouldRequireValidLinkItemId()
    {
        var command = new UpdateLinkItemCommand { Id = 99, Name = "New Title" };
        await FluentActions.Invoking(() => SendAsync(command)).Should().ThrowAsync<NotFoundException>();
    }

    [Test]
    public async Task ShouldUpdateLinkItem()
    {
        var userId = await RunAsDefaultUserAsync();

        var itemId = await SendAsync(new CreateLinkItemCommand
        {
            Name = "New Item"
        });

        var command = new UpdateLinkItemCommand
        {
            Id = itemId,
            Name = "Updated Item Name"
        };

        await SendAsync(command);

        var item = await FindAsync<LinkItem>(itemId);

        item.Should().NotBeNull();
        item!.Name.Should().Be(command.Name);
        item.LastModifiedBy.Should().NotBeNull();
        item.LastModifiedBy.Should().Be(userId);
        item.LastModified.Should().BeCloseTo(DateTime.Now, TimeSpan.FromMilliseconds(10000));
    }
}

