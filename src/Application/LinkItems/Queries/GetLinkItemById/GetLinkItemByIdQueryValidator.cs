namespace Socials.Application.LinkItems.Queries.GetLinkItemById;

public class GetLinkItemByIdQueryValidator : AbstractValidator<GetLinkItemByIdQuery>
{
    public GetLinkItemByIdQueryValidator()
    {
        RuleFor(x => x.Id)
            .NotEmpty().WithMessage("Id is required.");
    }
}
