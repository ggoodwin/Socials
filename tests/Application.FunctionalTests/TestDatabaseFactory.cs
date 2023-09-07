namespace Socials.Application.FunctionalTests;

public static class TestDatabaseFactory
{
    public static async Task<ITestDatabase> CreateAsync()
    {

        #if DEBUG
            var database = new SqlServerTestDatabase();
        #else
            var database = new TestContainersTestDatabase();
        #endif

        await database.InitializeAsync();

        return database;
    }
}
