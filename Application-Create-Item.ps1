###############################################
# Setup
###############################################
#----------------------------------------------
# Input
#----------------------------------------------
# Ask for Name of Item to Create
$name = Read-Host "Enter the name of the item to create" -ForegroundColor Green

#----------------------------------------------
# Variables
#----------------------------------------------
$appname = "Socials" ###---EDIT ME---###
$application = "$PWD\src\Application"
$domain = "$PWD\src\Domain"
$infrastructure = "$PWD\src\Infrastructure"
$web = "$PWD\src\Web"
$applicationFunctionalTests = "$PWD\tests\Application.FunctionalTests"

# Template Folders
$applicationTemplates = "$($application)\Templates"
$domainTemplates = "$($domain)\Templates"
$infrastructureTemplates = "$($infrastructure)\Templates"
$webTemplates = "$($web)\Templates"
$afpTemplates = "$($applicationFunctionalTests)\Templates"

###############################################
# Application Project
###############################################
Write-Host "----------------------------------------" -ForegroundColor Green
Write-Host "Starting work on the Application Project" -ForegroundColor Green
Write-Host "----------------------------------------" -ForegroundColor Green

Write-Host "Creating Application Folders" -ForegroundColor Green
# / Creating Folders
# Create Main Folder
New-Item -Path "$($application)\$($name)s" -ItemType Directory
Write-Host "Created: '$($application)\$($name)s' Folder" -ForegroundColor Green

# Set Paths
$commands = "$($application)\$($name)s\Commands"
$events = "$($application)\$($name)s\EventHandlers"
$queries = "$($application)\$($name)s\Queries"

# Create Base Folders
New-Item -Path $commands -ItemType Directory
Write-Host "Created: '$($command)' Folder" -ForegroundColor Green
New-Item -Path $events -ItemType Directory
Write-Host "Created: '$($events)' Folder" -ForegroundColor Green
New-Item -Path $queries -ItemType Directory
Write-Host "Created: '$($queries)' Folder" -ForegroundColor Green

# Create Command Folders
New-Item -Path "$($commands)\Create$($name)" -ItemType Directory
Write-Host "Created: '$($commands)\Create$($name)' Folder" -ForegroundColor Green
New-Item -Path "$($commands)\Delete$($name)" -ItemType Directory
Write-Host "Created: '$($commands)\Delete$($name)' Folder" -ForegroundColor Green
New-Item -Path "$($commands)\Update$($name)" -ItemType Directory
Write-Host "Created: '$($commands)\Update$($name)' Folder" -ForegroundColor Green

# Create Query Folders
New-Item -Path "$($queries)\GetAll$($name)sWithPagination" -ItemType Directory
Write-Host "Created: '$($queries)\GetAll$($name)sWithPagination' Folder" -ForegroundColor Green
New-Item -Path "$($queries)\GetAll$($name)sByUser" -ItemType Directory
Write-Host "Created: '$($queries)\GetAll$($name)sWithPagination' Folder" -ForegroundColor Green
New-Item -Path "$($queries)\Get$($name)ById" -ItemType Directory
Write-Host "Created: '$($queries)\GetAll$($name)sWithPagination' Folder" -ForegroundColor Green

Write-Host "Editing Application Files" -ForegroundColor Green
# / Edit Files
# Add new table to DbContext Interface
$dbContextPath = "$($application)\Common\Interfaces\IApplicationDbContext.cs"
$content = Get-Content -Path $dbContextPath
if ($content.Count -gt 0) {
    $content = $content[0..($content.Count - 2)]
}
$content | Set-Content -Path $dbContextPath
$lineToAdd = "  DbSet<$($name)> $($name)s { get; }`n"
$lineToAdd += "}"
Add-Content -Path $dbContextPath -Value $lineToAdd
Write-Host "Added to File: '$dbContextPath'" -ForegroundColor Green

# Add new table to LookupDTO
$lookUpDto = "$($application)\Common\Models\LookupDto.cs"
$content = Get-Content -Path $lookUpDto
if ($content.Count -gt 2) {
    $content = $content[0..($content.Count - 4)]
}
$content | Set-Content -Path $lookUpDto
$lineToAdd =  "      CreateMap<$($name), LookupDto>();`n"
$lineToAdd += "    }`n"
$lineToAdd += "  }`n"
$lineToAdd += "}"
Add-Content -Path $lookUpDto -Value $lineToAdd
Write-Host "Added to File: '$lookUpDto'" -ForegroundColor Green

Write-Host "Creating Application Files" -ForegroundColor Green
# / Creating Files
# - Commands
#   - Create
#     - Create.cs
$filePath = "$($commands)\Create$($name)\Create$($name).cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green
#     - CreateCommandValidator.cs
$filePath = "$($commands)\Create$($name)\Create$($name)CommandValidator.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green

# - Commands
#   - Delete
#     - Delete.cs
$filePath = "$($commands)\Delete$($name)\Delete$($name).cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green

# - Commands
#   - Update
#     - Update.cs
$filePath = "$($commands)\Update$($name)\Update$($name).cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green
#     - UpdateCommandValidator.cs
$filePath = "$($commands)\Update$($name)\Update$($name)CommandValidator.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green

# - Queries
#   - BriefDto.cs
$filePath = "$($queries)\$($name)BriefDto.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green
#   - GetAllWithPagination
#     - GetAllWithPagination.cs
$filePath = "$($queries)\GetAll$($name)sWithPagination\GetAll$($name)sWithPagination.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green
#     - GetAllWithPaginationQueryValidator.cs
$filePath = "$($queries)\GetAll$($name)sWithPagination\GetAll$($name)sWithPaginationQueryValidator.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green
#   - GetAllByUser
#     - GetAllByUser.cs
$filePath = "$($queries)\GetAll$($name)sByUser\GetAll$($name)sByUser.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green
#     - GetAllByUserQueryValidator.cs
$filePath = "$($queries)\GetAll$($name)sByUser\GetAll$($name)sByUserQueryValidator.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green
#   - GetById
#     - GetById.cs
$filePath = "$($queries)\Get$($name)ById\Get$($name)ById.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green
#     - GetByIdQueryValidator.cs
$filePath = "$($queries)\Get$($name)ById\Get$($name)ByIdQueryValidator.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green

# - EventHandlers
#   - CompletedEventHandler.cs
$filePath = "$($events)\$($name)CompletedEventHandler.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green
#   - CreatedEventHandler.cs
$filePath = "$($events)\$($name)CreatedEventHandler.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green

Write-Host "Writing Code to Application Files" -ForegroundColor Green
# / Write Code to Files
# - Commands
#   - Create
#     - Create.cs
$templatePath = "$($applicationTemplates)\Commands\Create\Create.txt"
$outputPath = "$($commands)\Create$($name)\Create$($name).cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green
#     - CreateCommandValidator.cs
$templatePath = "$($applicationTemplates)\Commands\Create\CreateCommandValidator.txt"
$outputPath = "$($commands)\Create$($name)\Create$($name)CommandValidator.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green

# - Commands
#   - Delete
#     - Delete.cs
$templatePath = "$($applicationTemplates)\Commands\Delete\Delete.txt"
$outputPath = "$($commands)\Delete$($name)\Delete$($name).cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green

# - Commands
#   - Update
#     - Update.cs
$templatePath = "$($applicationTemplates)\Commands\Update\Update.txt"
$outputPath = "$($commands)\Update$($name)\Update$($name).cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green
#     - UpdateCommandValidator.cs
$templatePath = "$($applicationTemplates)\Commands\Update\UpdateCommandValidator.txt"
$outputPath = "$($commands)\Update$($name)\Update$($name)CommandValidator.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green

# - Queries
#   - BriefDto.cs
$templatePath = "$($applicationTemplates)\Queries\BriefDto.txt"
$outputPath = "$($queries)\$($name)BriefDto.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green
#   - GetAllWithPagination
#     - GetAllWithPagination.cs
$templatePath = "$($applicationTemplates)\Queries\GetAllWithPagination\GetAllWithPagination.txt"
$outputPath = "$($queries)\GetAll$($name)sWithPagination\GetAll$($name)sWithPagination.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green
#     - GetWithPaginationQueryValidator.cs
$templatePath = "$($applicationTemplates)\Queries\GetAllWithPagination\GetAllWithPaginationQueryValidator.txt"
$outputPath = "$($queries)\GetAll$($name)sWithPagination\GetAll$($name)sWithPaginationQueryValidator.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green
#   - GetAllByUser
#     - GetAllByUser.cs
$templatePath = "$($applicationTemplates)\Queries\GetAllByUser\GetAllByUser.txt"
$outputPath = "$($queries)\GetAll$($name)sByUser\GetAll$($name)sByUser.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green
#     - GetAllByUserQueryValidator.cs
$templatePath = "$($applicationTemplates)\Queries\GetAllByUser\GetAllByUserQueryValidator.txt"
$outputPath = "$($queries)\GetAll$($name)sByUser\GetAll$($name)sByUserQueryValidator.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green
#   - GetById
#     - GetById.cs
$templatePath = "$($applicationTemplates)\Queries\GetById\GetById.txt"
$outputPath = "$($queries)\Get$($name)ById\Get$($name)ById.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green
#     - GetByIdQueryValidator.cs
$templatePath = "$($applicationTemplates)\Queries\GetById\GetByIdQueryValidator.txt"
$outputPath = "$($queries)\Get$($name)ById\Get$($name)ByIdQueryValidator.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green

# - EventHandlers
#   - CompletedEventHandler.cs
$templatePath = "$($applicationTemplates)\EventHandlers\CompletedEventHandler.txt"
$outputPath = "$($events)\$($name)CompletedEventHandler.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green
#   - CreatedEventHandler.cs
$templatePath = "$($applicationTemplates)\EventHandlers\CreatedEventHandler.txt"
$outputPath = "$($events)\$($name)CreatedEventHandler.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Created File: '$outputPath'" -ForegroundColor Green

###############################################
# Domain Project
###############################################
Write-Host "-----------------------------------" -ForegroundColor Green
Write-Host "Starting work on the Domain Project" -ForegroundColor Green
Write-Host "-----------------------------------" -ForegroundColor Green

Write-Host "Creating Domain Folders" -ForegroundColor Green
# / Folder Creation
# Create Events Folders
New-Item -Path "$($domain)\Events\$($name)" -ItemType Directory
Write-Host "Created: '$($domain)\Events\$($name)' Folder" -ForegroundColor Green

Write-Host "Creating Domain Files" -ForegroundColor Green
# / File Creation
# - Entities
#   - Table.cs
$filePath = "$($domain)\Entities\$($name).cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created: '$filePath' Folder" -ForegroundColor Green
# - Events
#  - CompletedEvent.cs
$filePath = "$($domain)\Events\$($name)\$($name)CompletedEvent.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created: '$filePath' Folder" -ForegroundColor Green
#  - CreatedEvent.cs
$filePath = "$($domain)\Events\$($name)\$($name)CreatedEvent.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created: '$filePath' Folder" -ForegroundColor Green
#  - DeletedEvent.cs
$filePath = "$($domain)\Events\$($name)\$($name)DeletedEvent.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created: '$filePath' Folder" -ForegroundColor Green

Write-Host "Writing Code to Domain Files" -ForegroundColor Green
# / Write Files
# - Entities
#   - Table.cs
$templatePath = "$($domainTemplates)\Entities\Table.txt"
$outputPath = "$($domain)\Entities\$($name).cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Wrote Code to '$outputPath' File" -ForegroundColor Green

# - Events
#   - Table
#     - CompletedEvent.cs
$templatePath = "$($templates)\Events\CompletedEvent.txt"
$outputPath = "$($domain)\Events\$($name)\$($name)CompletedEvent.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Wrote Code to '$outputPath' File" -ForegroundColor Green
#     - CreatedEvent.cs
$templatePath = "$($templates)\Events\CreatedEvent.txt"
$outputPath = "$($domain)\Events\$($name)\$($name)CreatedEvent.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Wrote Code to '$outputPath' File" -ForegroundColor Green
#     - DeletedEvent.cs
$templatePath = "$($templates)\Events\DeletedEvent.txt"
$outputPath = "$($domain)\Events\$($name)\$($name)DeletedEvent.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Wrote Code to '$outputPath' File" -ForegroundColor Green

###############################################
# Infrastructure Project
###############################################
Write-Host "-------------------------------------------" -ForegroundColor Green
Write-Host "Starting work on the Infrastructure Project" -ForegroundColor Green
Write-Host "-------------------------------------------" -ForegroundColor Green

Write-Host "Editing Infrastructure Files" -ForegroundColor Green
# / Editing Files
# Add new table to DbContext
$dbContextPath = "$($infrastructure)\Data\ApplicationDbContext.cs"
$content = Get-Content -Path $dbContextPath
if ($content.Count -gt 1) {
    $content = $content[0..($content.Count - 3)]
}
$content | Set-Content -Path $dbContextPath
$lineToAdd =  "  public DbSet<$($name)> $($name)s => Set<$($name)>();`n"
$lineToAdd += "}"
Add-Content -Path $dbContextPath -Value $lineToAdd
Write-Host "Edited File: '$dbContextPath'" -ForegroundColor Green
# Add new table to Initializer
$dbContextPathInit = "$($infrastructure)\Data\ApplicationDbContextInitializer.cs"
$content = Get-Content -Path $dbContextPathInit
if ($content.Count -gt 2) {
    $content = $content[0..($content.Count - 4)]
}
$content | Set-Content -Path $dbContextPathInit
$lineToAdd =  "    // Seed, if necessary`n"
$lineToAdd += "    if (!_context.$($name)s.Any())`n"
$lineToAdd += "    {`n"
$lineToAdd += "      _context.$($name)s.Add(new $($name)`n"
$lineToAdd += "      {`n"
$lineToAdd += "        Title = 'Test $($name)'`n"
$lineToAdd += "      });`n"
$lineToAdd += "      await _context.SaveChangesAsync();`n"
$lineToAdd += "    }`n"
$lineToAdd += "  }`n"
$lineToAdd += "}"
Add-Content -Path $dbContextPathInit -Value $lineToAdd
Write-Host "Edited File: '$dbContextPathInit'" -ForegroundColor Green

Write-Host "Creating Infrastructure Files" -ForegroundColor Green
# / Create Files
# - Data
#   - Configurations
#     - Configuration.cs
$filePath = "$($infrastructure)\Data\Configurations\$($name)Configuration.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green

Write-Host "Writing Code to Infrastructure Files" -ForegroundColor Green
# / Write Code to Files
# - Data
#   - Configurations
#     - Configuration.cs
$templatePath = "$($infrastructureTemplates)\Data\Configurations\Configuration.txt"
$outputPath = "$($infrastructure)\Data\Configurations\$($name)Configuration.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Added Code to File: '$outputPath'" -ForegroundColor Green

###############################################
# Web Project
###############################################
Write-Host "--------------------------------" -ForegroundColor Green
Write-Host "Starting work on the Web Project" -ForegroundColor Green
Write-Host "--------------------------------" -ForegroundColor Green

Write-Host "Creating Web Files" -ForegroundColor Green
# / Create Files
# - Endpoints
#  - Table.cs
$filePath = "$($web)\Endpoints\$($name).cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green

Write-Host "Editing Web Files" -ForegroundColor Green
# / Edit Files
$templatePath = "$($webTemplates)\Web.http.txt"
$webHttpPath = "$($web)\Web.http"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $filledContent -replace "\[ITEM\]", $name
Add-Content -Path $webHttpPath -Value $filledContent
Write-Host "Edited File: '$webHttpPath'" -ForegroundColor Green

###############################################
# Application Function Test Project
###############################################
Write-Host "------------------------------------------------------" -ForegroundColor Green
Write-Host "Starting work on the Application Function Test Project" -ForegroundColor Green
Write-Host "------------------------------------------------------" -ForegroundColor Green

Write-Host "Creating Application Functional Test Folders" -ForegroundColor Green
# / Create Folders
# Create Main Folder
New-Item -Path "$($applicationFunctionalTests)\$($name)s" -ItemType Directory
Write-Host "Created Folder: '$($applicationFunctionalTests)\$($name)s'" -ForegroundColor Green

Write-Host "Creating Application Functional Test Files" -ForegroundColor Green
# / Create Files
# - Table
#   - Commands
#       - CreateTests.cs
$filePath = "$($applicationFunctionalTests)\$($name)s\Commands\Create$($name)Tests.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green
#       - DeleteTests.cs
$filePath = "$($applicationFunctionalTests)\$($name)s\Commands\Delete$($name)Tests.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green
#       - UpdateTests.cs
$filePath = "$($applicationFunctionalTests)\$($name)s\Commands\Update$($name)Tests.cs"
New-Item -Path $filePath -ItemType File
Write-Host "Created File: '$filePath'" -ForegroundColor Green

Write-Host "Writing Code to Application Functional Test Files" -ForegroundColor Green
# / Write Code to Files
# - Table
#   - Commands
#     - CreateTests.cs
$templatePath = "$($afpTemplates)\Table\Commands\CreateTests.txt"
$outputPath = "$($applicationFunctionalTests)\$($name)s\Commands\Create$($name)Tests.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Edited File: '$outputPath'" -ForegroundColor Green
#     - DeleteTests.cs
$templatePath = "$($afpTemplates)\Table\Commands\DeleteTests.txt"
$outputPath = "$($applicationFunctionalTests)\$($name)s\Commands\Delete$($name)Tests.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Edited File: '$outputPath'" -ForegroundColor Green
#     - UpdateTests.cs
$templatePath = "$($afpTemplates)\Table\Commands\UpdateTests.txt"
$outputPath = "$($applicationFunctionalTests)\$($name)s\Commands\Update$($name)Tests.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
Write-Host "Edited File: '$outputPath'" -ForegroundColor Green

###############################################
# Finishing Up
###############################################
Write-Host "-------------" -ForegroundColor Green
Write-Host "Finishing Up " -ForegroundColor Green
Write-Host "-------------" -ForegroundColor Green

pause
