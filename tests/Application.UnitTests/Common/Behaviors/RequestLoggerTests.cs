using Socials.Application.Common.Behaviors;
using Socials.Application.Common.Interfaces;
using Socials.Application.LinkItems.Commands.CreateLinkItem;
using Microsoft.Extensions.Logging;
using Moq;
using NUnit.Framework;

namespace Socials.Application.UnitTests.Common.Behaviors;

public class RequestLoggerTests
{
    private Mock<ILogger<CreateLinkItemCommand>> _logger = null!;
    private Mock<IUser> _user = null!;
    private Mock<IIdentityService> _identityService = null!;

    [SetUp]
    public void Setup()
    {
        _logger = new Mock<ILogger<CreateLinkItemCommand>>();
        _user = new Mock<IUser>();
        _identityService = new Mock<IIdentityService>();
    }

    [Test]
    public async Task ShouldCallGetUserNameAsyncOnceIfAuthenticated()
    {
        _user.Setup(x => x.Id).Returns(Guid.NewGuid().ToString());

        var requestLogger = new LoggingBehavior<CreateLinkItemCommand>(_logger.Object, _user.Object, _identityService.Object);

        await requestLogger.Process(new CreateLinkItemCommand { Title = "Title" }, new CancellationToken());

        _identityService.Verify(i => i.GetUserNameAsync(It.IsAny<string>()), Times.Once);
    }

    [Test]
    public async Task ShouldNotCallGetUserNameAsyncOnceIfUnauthenticated()
    {
        var requestLogger = new LoggingBehavior<CreateLinkItemCommand>(_logger.Object, _user.Object, _identityService.Object);

        await requestLogger.Process(new CreateLinkItemCommand { Title = "Title" }, new CancellationToken());

        _identityService.Verify(i => i.GetUserNameAsync(It.IsAny<string>()), Times.Never);
    }
}
