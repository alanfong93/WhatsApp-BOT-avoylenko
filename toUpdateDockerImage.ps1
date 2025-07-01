# functions
function ShutdownAndRemoveContainers {
    ###### Shut Down and Remove The Related Containers
    Write-Host "Shutting Down and Removing The Related Containers....." -ForegroundColor White -BackgroundColor DarkRed -NoNewline

    docker-compose down

    Write-Host "The Related Containers Have Shut Down and Been Removed Successfully!" -ForegroundColor White -BackgroundColor DarkGreen
}

function TestingMode {
    ###### Create and Run the Containers Based on the New Image
    Write-Host "Building, Creating and Running the Containers....." -ForegroundColor White -BackgroundColor DarkRed
    
    # Step 1: Build the image without cache
    docker-compose -f docker-compose.testing.yml build --no-cache

    # Step 2: Start the container
    docker-compose -f docker-compose.testing.yml up -d

    Write-Host "The Containers Have Been Created and Started Successfully!" -ForegroundColor White -BackgroundColor DarkGreen
}

function DevelopmentMode {
    ###### Rebuild the Docker Image
    Write-Host "Rebuilding the Docker Image....." -ForegroundColor White -BackgroundColor DarkRed

    # Command to build the images
    docker-compose build

    Write-Host "Docker Image Rebuilt Successfully!" -ForegroundColor White -BackgroundColor DarkGreen

    ###### Create and Run the Containers Based on the New Image
    Write-Host "Creating and Running the Containers....." -ForegroundColor White -BackgroundColor DarkRed

    # Command to start up containers
    docker-compose up -d

    Write-Host "The Containers Have Been Created and Started Successfully!" -ForegroundColor White -BackgroundColor DarkGreen
}

function ProductionMode {
    ###### Create and Run the Containers Based on the New Image
    Write-Host "Building, Creating and Running the Containers....." -ForegroundColor White -BackgroundColor DarkRed
    
    # Step 1: Build the image without cache
    docker-compose -f docker-compose.yml build --no-cache

    # Step 2: Start the container
    docker-compose -f docker-compose.yml up -d

    Write-Host "The Containers Have Been Created and Started Successfully!" -ForegroundColor White -BackgroundColor DarkGreen
}

# Prompt the user to choose the environment
$environment = Read-Host "Enter the environment mode -> production/development/testing (p/d/t)"

if ($environment -eq "testing" -or $environment.ToUpper() -eq "T") {
    ShutdownAndRemoveContainers
    Write-Host "Running in Test Environment..." -ForegroundColor White -BackgroundColor DarkYellow
    TestingMode
} elseif ($environment -eq "production" -or $environment.ToUpper() -eq "P") {
    ShutdownAndRemoveContainers
    Write-Host "Running in Production Environment..." -ForegroundColor White -BackgroundColor DarkYellow
    ProductionMode
} elseif ($environment -eq "development" -or $environment.ToUpper() -eq "D") {
    ShutdownAndRemoveContainers
    Write-Host "Running in Production Environment..." -ForegroundColor White -BackgroundColor DarkYellow
    DevelopmentMode
} else {
    Write-Host "Invalid environment choice. Please choose 'production' or 'test'." -ForegroundColor Red
    exit
}
