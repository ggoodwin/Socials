namespace Socials.Web.AcceptanceTests.Pages;

public class LoginPage : BasePage
{
    private LoginPage(IBrowser browser, IPage page)
    {
        Browser = browser;
        Page = page;
    }

    public static LoginPage CreateInstance(IBrowser browser, IPage page)
    {
        return new LoginPage(browser, page);
    }

    public override string PagePath => $"{BaseUrl}/Identity/Account/Login";

    public override IBrowser Browser { get; }

    public sealed override IPage Page { get; set; }

    public Task SetEmail(string email)
        => Page.FillAsync("#Input_Email", email);

    public Task SetPassword(string password)
        => Page.FillAsync("#Input_Password", password);

    public Task ClickLogin()
        => Page.Locator("#login-submit").ClickAsync();

    public Task<string?> ProfileLinkText()
        => Page.Locator("a[href='/Identity/Account/Manage']").TextContentAsync();

    public Task<bool> InvalidLoginAttemptMessageVisible()
        => Page.Locator("text=Invalid login attempt.").IsVisibleAsync();
}
