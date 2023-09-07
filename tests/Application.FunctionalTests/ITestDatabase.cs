using System.Data.Common;

namespace Socials.Application.FunctionalTests;

public interface ITestDatabase
{
    Task InitializeAsync();

    DbConnection GetConnection();

    Task ResetAsync();

    Task DisposeAsync();
}
