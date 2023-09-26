namespace Socials.Application.LinkItems.Commands.UpdateLinkItem;

public class UpdateLinkItemCommandValidator : AbstractValidator<UpdateLinkItemCommand>
{
    public UpdateLinkItemCommandValidator()
    {
        RuleFor(v => v.Title)
            .MaximumLength(40)
            .NotEmpty();
        RuleFor(v => v.Url)
            .NotEmpty();
        RuleFor(v => v.Favicon)
            .NotEmpty();
    }
}
