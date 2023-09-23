﻿using System.Reflection;
using System.Runtime.Serialization;
using AutoMapper;
using Socials.Application.Common.Interfaces;
using Socials.Application.Common.Models;
using Socials.Application.TodoItems.Queries.GetTodoItemsWithPagination;
using Socials.Application.TodoLists.Queries.GetTodos;
using Socials.Domain.Entities;
using NUnit.Framework;

namespace Socials.Application.UnitTests.Common.Mappings;

public class MappingTests
{
    private readonly IConfigurationProvider _configuration;
    private readonly IMapper _mapper;

    public MappingTests()
    {
        _configuration = new MapperConfiguration(config => 
            config.AddMaps(Assembly.GetAssembly(typeof(IApplicationDbContext))));

        _mapper = _configuration.CreateMapper();
    }

    [Test]
    public void ShouldHaveValidConfiguration()
    {
        _configuration.AssertConfigurationIsValid();
    }

    [Test]
    [TestCase(typeof(TodoList), typeof(TodoListDto))]
    [TestCase(typeof(TodoItem), typeof(TodoItemDto))]
    [TestCase(typeof(TodoList), typeof(LookupDto))]
    [TestCase(typeof(TodoItem), typeof(LookupDto))]
    [TestCase(typeof(TodoItem), typeof(TodoItemBriefDto))]
    // TODO: Add more test cases and assertions
#pragma warning disable S2699 // Tests should include assertions
    public void ShouldSupportMappingFromSourceToDestination(Type source, Type destination)
#pragma warning restore S2699 // Tests should include assertions
    {
        var instance = GetInstanceOf(source);

        _mapper.Map(instance, source, destination);
    }

    private static object GetInstanceOf(Type type)
    {
        if (type.GetConstructor(Type.EmptyTypes) != null)
            return Activator.CreateInstance(type)!;

        // Type without parameter-less constructor
        // TODO: Figure out an alternative approach to the now obsolete `FormatterServices.GetUninitializedObject` method.
#pragma warning disable SYSLIB0050 // Type or member is obsolete
        return FormatterServices.GetUninitializedObject(type);
#pragma warning restore SYSLIB0050 // Type or member is obsolete
    }
}
