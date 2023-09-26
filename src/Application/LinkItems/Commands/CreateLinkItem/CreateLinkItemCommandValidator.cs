namespace Socials.Application.LinkItems.Commands.CreateLinkItem;

public class CreateLinkItemCommandValidator : AbstractValidator<CreateLinkItemCommand>
{
    public CreateLinkItemCommandValidator()
    {
        RuleFor(v => v.Title)
            .MaximumLength(40)
            .NotEmpty();
        RuleFor(v => v.Url)
            .NotEmpty();
        RuleFor(v => v.Favicon)
            .NotEmpty();
        RuleFor(v => v.UserId)
            .NotEmpty();
    }
}
