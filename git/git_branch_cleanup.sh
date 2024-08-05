#!/bin/bash


# Fetch the latest changes from the remote
git fetch --prune

# Get the name of the current branch
current_branch=$(git branch --show-current)

# Define the branch to keep
branch_to_keep="main"

# List all local branches
branches=$(git branch --format='%(refname:short)')

# Loop through each branch
for branch in $branches; {
    # Skip the branch to keep and the current branch
    if [ "$branch" != "$branch_to_keep" ] && [ "$branch" != "$current_branch" ]; then
        # Force delete the branch
        git branch -D "$branch"
    fi
}

echo "Deleted all branches except '$branch_to_keep' and the current branch '$current_branch'."

