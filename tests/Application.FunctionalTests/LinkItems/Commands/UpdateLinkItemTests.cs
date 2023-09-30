using Socials.Application.LinkItems.Commands.CreateLinkItem;
using Socials.Application.LinkItems.Commands.UpdateLinkItem;
using Socials.Domain.Entities;

namespace Socials.Application.FunctionalTests.LinkItems.Commands;

using static Testing;

public class UpdateLinkItemTests : BaseTestFixture
{
    [Test]
    public async Task ShouldRequireValidLinkItemId()
    {
        var command = new UpdateLinkItemCommand { Id = 99, Title = "New Title" };
        await FluentActions.Invoking(() => SendAsync(command)).Should().ThrowAsync<NotFoundException>();
    }

    [Test]
    public async Task ShouldUpdateLinkItem()
    {
        var userId = await RunAsDefaultUserAsync();

        var itemId = await SendAsync(new CreateLinkItemCommand
        {
            Title = "New LinkItem"
        });

        var command = new UpdateLinkItemCommand
        {
            Id = itemId,
            Title = "Updated LinkItem Title"
        };

        await SendAsync(command);

        var item = await FindAsync<LinkItem>(itemId);

        item.Should().NotBeNull();
        item!.Title.Should().Be(command.Title);
        item.LastModifiedBy.Should().NotBeNull();
        item.LastModifiedBy.Should().Be(userId);
        item.LastModified.Should().BeCloseTo(DateTime.Now, TimeSpan.FromMilliseconds(10000));
    }
}

