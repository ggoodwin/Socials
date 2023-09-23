#----------------------------------------------
# Input
#----------------------------------------------
# Ask for Name of Item to Create
$appname = "Socials"
$name = Read-Host "Enter the name of the item to create"

$application = "$PWD\src\Application"
$domain = "$PWD\src\Domain"
$infrastructure = "$PWD\src\Infrastructure"
$web = "$PWD\src\Web"
$applicationFunctionalTests = "$PWD\tests\Application.FunctionalTests"

#----------------------------------------------
# Application Folder Creation
#----------------------------------------------
# Create Main Folder
New-Item -Path "$($application)\$($name)s" -ItemType Directory

# Set Paths
$commands = "$($application)\$($name)s\Commands"
$events = "$($application)\$($name)s\EventHandlers"
$queries = "$($application)\$($name)s\Queries"

# Create Base Folders
New-Item -Path $commands -ItemType Directory
New-Item -Path $events -ItemType Directory
New-Item -Path $queries -ItemType Directory

# Create Command Folders
New-Item -Path "$($commands)\Create$($name)" -ItemType Directory
New-Item -Path "$($commands)\Delete$($name)" -ItemType Directory
New-Item -Path "$($commands)\Update$($name)" -ItemType Directory

# Create Query Folders
New-Item -Path "$($queries)\GetAll$($name)sWithPagination" -ItemType Directory
New-Item -Path "$($queries)\GetAll$($name)sByUser" -ItemType Directory
New-Item -Path "$($queries)\Get$($name)ById" -ItemType Directory

#----------------------------------------------
# Domain Folder Creation
#----------------------------------------------
# Create Events Folders
New-Item -Path "$($domain)\Events\$($name)" -ItemType Directory

#----------------------------------------------
# Application Function Test Folder Creation
#----------------------------------------------
# Create Main Folder
New-Item -Path "$($applicationFunctionalTests)\$($name)" -ItemType Directory

#----------------------------------------------
# Application Create Files
#----------------------------------------------
# - Commands
#   - Create
#     - Create.cs
$filePath = "$($commands)\Create$($name)\Create$($name).cs"
New-Item -Path $filePath -ItemType File
#     - CreateCommandValidator.cs
$filePath = "$($commands)\Create$($name)\Create$($name)CommandValidator.cs"
New-Item -Path $filePath -ItemType File

# - Commands
#   - Delete
#     - Delete.cs
$filePath = "$($commands)\Delete$($name)\Delete$($name).cs"
New-Item -Path $filePath -ItemType File

# - Commands
#   - Update
#     - Update.cs
$filePath = "$($commands)\Update$($name)\Update$($name).cs"
New-Item -Path $filePath -ItemType File
#     - UpdateCommandValidator.cs
$filePath = "$($commands)\Update$($name)\Update$($name)CommandValidator.cs"
New-Item -Path $filePath -ItemType File

# - Queries
#   - BriefDto.cs
$filePath = "$($queries)\$($name)BriefDto.cs"
New-Item -Path $filePath -ItemType File
#   - GetAllWithPagination
#     - GetAllWithPagination.cs
$filePath = "$($queries)\GetAll$($name)sWithPagination\GetAll$($name)sWithPagination.cs"
New-Item -Path $filePath -ItemType File
#     - GetAllWithPaginationQueryValidator.cs
$filePath = "$($queries)\GetAll$($name)sWithPagination\GetAll$($name)sWithPaginationQueryValidator.cs"
New-Item -Path $filePath -ItemType File
#   - GetAllByUser
#     - GetAllByUser.cs
$filePath = "$($queries)\GetAll$($name)sByUser\GetAll$($name)sByUser.cs"
New-Item -Path $filePath -ItemType File
#     - GetAllByUserQueryValidator.cs
$filePath = "$($queries)\GetAll$($name)sByUser\GetAll$($name)sByUserQueryValidator.cs"
New-Item -Path $filePath -ItemType File
#   - GetById
#     - GetById.cs
$filePath = "$($queries)\Get$($name)ById\Get$($name)ById.cs"
New-Item -Path $filePath -ItemType File
#     - GetByIdQueryValidator.cs
$filePath = "$($queries)\Get$($name)ById\Get$($name)ByIdQueryValidator.cs"
New-Item -Path $filePath -ItemType File

# - EventHandlers
#   - CompletedEventHandler.cs
$filePath = "$($events)\$($name)CompletedEventHandler.cs"
New-Item -Path $filePath -ItemType File
#   - CreatedEventHandler.cs
$filePath = "$($events)\$($name)CreatedEventHandler.cs"
New-Item -Path $filePath -ItemType File

#----------------------------------------------
# Domain Create Files
#----------------------------------------------
# - Entities
#   - Table.cs
$filePath = "$($domain)\Entities\$($name).cs"
New-Item -Path $filePath -ItemType File
# - Events
#  - CompletedEvent.cs
$filePath = "$($domain)\Events\$($name)\$($name)CompletedEvent.cs"
New-Item -Path $filePath -ItemType File
#  - CreatedEvent.cs
$filePath = "$($domain)\Events\$($name)\$($name)CreatedEvent.cs"
New-Item -Path $filePath -ItemType File
#  - DeletedEvent.cs
$filePath = "$($domain)\Events\$($name)\$($name)DeletedEvent.cs"
New-Item -Path $filePath -ItemType File

#----------------------------------------------
# Infrastructure Create Files
#----------------------------------------------
# - Data
#   - Configurations
#     - Configuration.cs
$filePath = "$($infrastructure)\Data\Configurations\$($name)Configuration.cs"
New-Item -Path $filePath -ItemType File

#----------------------------------------------
# Web Create Files
#----------------------------------------------
# - Endpoints
#  - Table.cs
$filePath = "$($web)\Endpoints\$($name).cs"
New-Item -Path $filePath -ItemType File

#----------------------------------------------
# Application Functional Tests Create Files
#----------------------------------------------
# - Table
#   - Commands
#       - CreateTests.cs
$filePath = "$($applicationFunctionalTests)\$($name)\Create$($name)Tests.cs"
New-Item -Path $filePath -ItemType File
#       - DeleteTests.cs
$filePath = "$($applicationFunctionalTests)\$($name)\Delete$($name)Tests.cs"
New-Item -Path $filePath -ItemType File
#       - UpdateTests.cs
$filePath = "$($applicationFunctionalTests)\$($name)\Update$($name)Tests.cs"
New-Item -Path $filePath -ItemType File

#----------------------------------------------
# Write to Files for Application
#----------------------------------------------
$templates = "$($application)\Templates"

# Add new table to DbContext Interface
$dbContextPath = "$($application)\Interfaces\IApplicationDbContext.cs"
$content = Get-Content -Path $dbContextPath
if ($content.Count -gt 0) {
    $content = $content[0..($content.Count - 2)]
}
$content | Set-Content -Path $dbContextPath
$lineToAdd = "  DbSet<$($name)> $($name)s { get; }"
$lineToAdd += "}"
Add-Content -Path $dbContextPath -Value $lineToAdd

# - Commands
#   - Create
#     - Create.cs
$templatePath = "$($templates)\Commands\Create\Create.txt"
$outputPath = "$($commands)\Create$($name)\Create$($name).cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#     - CreateCommandValidator.cs
$templatePath = "$($templates)\Commands\Create\CreateCommandValidator.txt"
$outputPath = "$($commands)\Create$($name)\Create$($name)CommandValidator.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath

# - Commands
#   - Delete
#     - Delete.cs
$templatePath = "$($templates)\Commands\Delete\Delete.txt"
$outputPath = "$($commands)\Delete$($name)\Delete$($name).cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath

# - Commands
#   - Update
#     - Update.cs
$templatePath = "$($templates)\Commands\Update\Update.txt"
$outputPath = "$($commands)\Update$($name)\Update$($name).cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#     - UpdateCommandValidator.cs
$templatePath = "$($templates)\Commands\Update\UpdateCommandValidator.txt"
$outputPath = "$($commands)\Update$($name)\Update$($name)CommandValidator.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath

# - Commands
#   - UpdateDetail
#     - UpdateDetail.cs
$templatePath = "$($templates)\Commands\UpdateDetail\UpdateDetail.txt"
$outputPath = "$($commands)\Update$($name)Detail\Update$($name)Detail.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath

# - Queries
#   - BriefDto.cs
$templatePath = "$($templates)\Queries\BriefDto.txt"
$outputPath = "$($queries)\$($name)BriefDto.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#   - GetAllWithPagination
#     - GetAllWithPagination.cs
$templatePath = "$($templates)\Queries\GetAllWithPagination\GetAllWithPagination.txt"
$outputPath = "$($queries)\GetAll$($name)sWithPagination\GetAll$($name)sWithPagination.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#     - GetWithPaginationQueryValidator.cs
$templatePath = "$($templates)\Queries\GetAllWithPagination\GetAllWithPaginationQueryValidator.txt"
$outputPath = "$($queries)\GetAll$($name)sWithPagination\GetAll$($name)sWithPaginationQueryValidator.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#   - GetAllByUser
#     - GetAllByUser.cs
$templatePath = "$($templates)\Queries\GetAllByUser\GetAllByUser.txt"
$outputPath = "$($queries)\GetAll$($name)sByUser\GetAll$($name)sByUser.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#     - GetAllByUserQueryValidator.cs
$templatePath = "$($templates)\Queries\GetAllByUser\GetAllByUserQueryValidator.txt"
$outputPath = "$($queries)\GetAll$($name)sByUser\GetAll$($name)sByUserQueryValidator.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#   - GetById
#     - GetById.cs
$templatePath = "$($templates)\Queries\GetById\GetById.txt"
$outputPath = "$($queries)\Get$($name)ById\Get$($name)ById.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#     - GetByIdQueryValidator.cs
$templatePath = "$($templates)\Queries\GetById\GetByIdQueryValidator.txt"
$outputPath = "$($queries)\Get$($name)ById\Get$($name)ByIdQueryValidator.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath

# - EventHandlers
#   - CompletedEventHandler.cs
$templatePath = "$($templates)\EventHandlers\CompletedEventHandler.txt"
$outputPath = "$($events)\$($name)CompletedEventHandler.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#   - CreatedEventHandler.cs
$templatePath = "$($templates)\EventHandlers\CreatedEventHandler.txt"
$outputPath = "$($events)\$($name)CreatedEventHandler.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath

#----------------------------------------------
# Write to Files for Domain
#----------------------------------------------
$templates = "$($domain)\Templates"

# - Entities
#   - Table.cs
$templatePath = "$($templates)\Entities\Table.txt"
$outputPath = "$($domain)\Entities\$($name).cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath

# - Events
#   - Table
#     - CompletedEvent.cs
$templatePath = "$($templates)\Events\CompletedEvent.txt"
$outputPath = "$($domain)\Events\$($name)\$($name)CompletedEvent.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#     - CreatedEvent.cs
$templatePath = "$($templates)\Events\CreatedEvent.txt"
$outputPath = "$($domain)\Events\$($name)\$($name)CreatedEvent.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#     - DeletedEvent.cs
$templatePath = "$($templates)\Events\DeletedEvent.txt"
$outputPath = "$($domain)\Events\$($name)\$($name)DeletedEvent.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath

#----------------------------------------------
# Write to Files for Infrastructure
#----------------------------------------------
$templates = "$($infrastructure)\Templates"
# Add new table to DbContext
$dbContextPath = "$($infrastructure)\Data\ApplicationDbContext.cs"
$content = Get-Content -Path $dbContextPath
if ($content.Count -gt 0) {
    $content = $content[0..($content.Count - 2)]
}
$content | Set-Content -Path $dbContextPath
$lineToAdd = "  public DbSet<$($name)> $($name)s => Set<$($name)>()"
$lineToAdd += "}"
Add-Content -Path $dbContextPath -Value $lineToAdd

# - Data
#   - Configurations
#     - Configuration.cs
$templatePath = "$($templates)\Data\Configutaions\Configuration.txt"
$outputPath = "$($infrastructure)\Data\Configurations\$($name)Configuration.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath

#----------------------------------------------
# Write to Files for Web
#----------------------------------------------
$templates = "$($web)\Templates"
# Add new API to Web.http
$templatePath = "$($templates)\Web.http.txt"
$webHttpPath = "$($web)\Web.http"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $filledContent -replace "\[ITEM\]", $name
Add-Content -Path $webHttpPath -Value $filledContent

#----------------------------------------------
# Write to Files for Application Functional Tests
#----------------------------------------------
$templates = "$($applicationFunctionalTests)\Templates"

# - Table
#   - Commands
#     - CreateTests.cs
$templatePath = "$($templates)\Table\Commands\CreateTests.txt"
$outputPath = "$($applicationFunctionalTests)\$($name)\Create$($name)Tests.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#     - DeleteTests.cs
$templatePath = "$($templates)\Table\Commands\DeleteTests.txt"
$outputPath = "$($applicationFunctionalTests)\$($name)\Delete$($name)Tests.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath
#     - UpdateTests.cs
$templatePath = "$($templates)\Table\Commands\UpdateTests.txt"
$outputPath = "$($applicationFunctionalTests)\$($name)\Update$($name)Tests.cs"
$templateContent = Get-Content -Path $templatePath -Raw
$filledContent = $templateContent -replace "\[APP\]", $appname
$filledContent = $filledContent -replace "\[ITEM\]", $name
$filledContent | Set-Content -Path $outputPath

#----------------------------------------------
# Finish Up
#----------------------------------------------
pause

Read-Host -Prompt "Complete. Press Enter..."
