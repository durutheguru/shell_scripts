#!/bin/bash


read -p "Enter Project name: " project_name
mkdir $project_name && cd $_

echo "Initializing Railway project..."
railway init -n $project_name

echo "Go to https://railway.com/dashboard and create project environment(s)..."

read -p "Enter Environment name to deploy: " env_name
railway link -p $project_name -e $env_name

# Create database
echo "Creating Postgres database..."
railway add -d postgres -s db

# Create backend service on railway
echo "Creating backend service..."
railway add -s backend

# Create frontend service on railway
echo "Creating frontend service..."
railway add -s frontend

# Create backend service on local
echo "Creating local backend project..."
gradle_init

# Create frontend service on local
echo "Creating local frontend project..."
vite_init

cd ..

git init

read -p "Enter remote repository URL: " remote_url
git remote add origin $remote_url

sem_ver_setup

echo "Visit your project repository URL: $remote_url"
echo "Create the following secrets: RAILWAY_STAGING_TOKEN, RAILWAY_PROD_TOKEN, RAILWAY_STAGING_ENV_ID, RAILWAY_PROD_ENV_ID, RAILWAY_API_TOKEN, RAILWAY_PROJECT_NAME"

mkdir -p .github/workflows

read -p "Enter templates directory: " templates_dir
cp $templates_dir/frontend-deploy.yml .github/workflows/frontend-deploy.yml
cp $templates_dir/backend-deploy.yml .github/workflows/backend-deploy.yml

git add .
git commit -m "Initial commit"

echo "Done..."

