using Socials.Application.Common.Exceptions;
using Socials.Application.TodoItems.Commands.CreateTodoItem;
using Socials.Application.TodoLists.Commands.CreateTodoList;
using Socials.Domain.Entities;

namespace Socials.Application.FunctionalTests.LinkItems.Commands;

using static Testing;

public class CreateLinkItemTests : BaseTestFixture
{
    [Test]
    public async Task ShouldRequireMinimumFields()
    {
        var command = new CreateLinkItemCommand();

        await FluentActions.Invoking(() =>
            SendAsync(command)).Should().ThrowAsync<ValidationException>();
    }

    [Test]
    public async Task ShouldCreateLinkItem()
    {
        var userId = await RunAsDefaultUserAsync();

        var command = new CreateLinkItemCommand
        {
            Name = "Name"
        };

        var itemId = await SendAsync(command);

        var item = await FindAsync<LinkItem>(itemId);

        item.Should().NotBeNull();
        item.Name.Should().Be(command.Name);
        item.CreatedBy.Should().Be(userId);
        item.Created.Should().BeCloseTo(DateTime.Now, TimeSpan.FromMilliseconds(10000));
        item.LastModifiedBy.Should().Be(userId);
        item.LastModified.Should().BeCloseTo(DateTime.Now, TimeSpan.FromMilliseconds(10000));
    }
}

