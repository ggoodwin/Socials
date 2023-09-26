using Socials.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Socials.Infrastructure.Data.Configurations;

public class LinkItemConfiguration : IEntityTypeConfiguration<LinkItem>
{
    public void Configure(EntityTypeBuilder<LinkItem> builder)
    {
        builder.Property(t => t.Title)
            .HasMaxLength(40)
            .IsRequired();
        builder.Property(t => t.Url)
            .NotEmpty();
        builder.Property(t => t.Favicon)
            .NotEmpty();
        builder.Property(t => t.UserId)
            .NotEmpty();
    }
}
