using Socials.Domain.Entities;

namespace Socials.Application.Common.Interfaces;

public interface IApplicationDbContext
{
    Task<int> SaveChangesAsync(CancellationToken cancellationToken);
    DbSet<LinkItem> LinkItems { get; }
}
