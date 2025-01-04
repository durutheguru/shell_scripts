#!/usr/bin/env bash

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "This script requires 'jq' but it was not found."
    echo "Please install jq (e.g., 'sudo apt-get install jq' on Ubuntu or 'brew install jq' on macOS)."
    exit 1
fi

echo "Fetching Spring dependencies metadata..."
METADATA=$(curl -s https://start.spring.io/dependencies)

if [[ -z "$METADATA" ]]; then
    echo "Failed to retrieve dependencies from start.spring.io."
    exit 1
fi

echo "Available Dependencies:"
echo "-----------------------"
echo "$METADATA" | jq -r '.dependencies | to_entries[] | "\(.key): \(.value.groupId):\(.value.artifactId) [\(.value.scope)]"'

echo
echo "Above is a list of dependencies with their ID: groupId:artifactId [scope]."
echo "Pick the dependencies you want by entering their IDs separated by spaces."
echo "For example: web actuator lombok devtools"
echo

# Prompt the user for project configuration
read -p "Enter project name (display name): " NAME
read -p "Enter group ID (e.g., com.example): " GROUP_ID
read -p "Enter artifact ID (project folder name): " ARTIFACT_ID
read -p "Enter package name (e.g., com.example.demo): " PACKAGE_NAME
read -p "Enter project version (e.g., 0.0.1-SNAPSHOT): " VERSION
read -p "Enter Java version (e.g., 17, 11, 8): " JAVA_VERSION
read -p "Enter Spring Boot version (leave blank for default): " BOOT_VERSION
read -p "Enter packaging type (jar or war): " PACKAGING
read -p "Use Gradle Kotlin DSL? (y/n): " USE_KOTLIN_DSL

# Determine Gradle project type based on DSL choice
if [[ "$USE_KOTLIN_DSL" == "y" || "$USE_KOTLIN_DSL" == "Y" ]]; then
    TYPE="gradle-project-kotlin"
else
    TYPE="gradle-project"
fi

read -p "Enter dependencies (space-separated by their IDs): " DEP_LIST

# Convert dependency list (space-separated) to comma-separated if not empty
DEPS=$(echo "$DEP_LIST" | tr ' ' ',')

if [[ -z "$PACKAGING" ]]; then
    PACKAGING="jar"
fi

if [[ -z "$VERSION" ]]; then
    VERSION="0.0.1-SNAPSHOT"
fi

BOOT_VERSION_PARAM=""
if [[ -n "$BOOT_VERSION" ]]; then
    BOOT_VERSION_PARAM="&bootVersion=$BOOT_VERSION"
fi

DEPS_PARAM=""
if [[ -n "$DEPS" ]]; then
    DEPS_PARAM="&dependencies=$DEPS"
fi

JAVA_VERSION_PARAM=""
if [[ -n "$JAVA_VERSION" ]]; then
    JAVA_VERSION_PARAM="&javaVersion=$JAVA_VERSION"
fi

URL="https://start.spring.io/starter.zip?type=$TYPE&language=java&groupId=$GROUP_ID&artifactId=$ARTIFACT_ID&name=$NAME&packageName=$PACKAGE_NAME&version=$VERSION&packaging=$PACKAGING$BOOT_VERSION_PARAM$DEPS_PARAM$JAVA_VERSION_PARAM"

echo "Generating Spring Boot project..."
echo "Downloading from: $URL"

# Download the project
curl -sSL "$URL" -o project.zip
if [[ $? -ne 0 ]]; then
    echo "Failed to download the project. Check your network or parameters."
    exit 1
fi

unzip -q project.zip -d "$ARTIFACT_ID"
rm project.zip

echo "Project generated in the '$ARTIFACT_ID' directory."
echo "Done."
