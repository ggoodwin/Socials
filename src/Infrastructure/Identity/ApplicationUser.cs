using Microsoft.AspNetCore.Identity;

namespace Socials.Infrastructure.Identity;

public class ApplicationUser : IdentityUser
{
  public string? DisplayName { get; set; }
  public string? Bio { get; set; }
  public string? Image { get; set; }
}
