﻿using Socials.Domain.Entities;

namespace Socials.Application.Common.Models;

public class LookupDto
{
    public int Id { get; init; }

    public string? Title { get; init; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<LinkItem, LookupDto>();    
        } 
    }
}
