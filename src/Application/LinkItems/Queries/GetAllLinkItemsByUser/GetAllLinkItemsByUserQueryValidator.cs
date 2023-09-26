namespace Socials.Application.LinkItems.Queries.GetAllLinkItemsByUser;

public class GetAllLinkItemsByUserQueryValidator : AbstractValidator<GetAllLinkItemsByUserQuery>
{
    public GetAllLinkItemsByUserQueryValidator()
    {
        RuleFor(x => x.UserId)
            .NotEmpty().WithMessage("UserId is required.");
    }
}

