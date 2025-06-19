#!/bin/bash
# Enhanced GitHub Sync Script
# Automates Git repository synchronization with logging, error handling, and batch processing

LOG_FILE="$HOME/scripts/github-sync.log"
BACKUP_DIR="$HOME/scripts/backups"
SYNC_DIR="$HOME/scripts"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Function to sync a single repository
sync_repo() {
    local repo_dir=$1
    cd "$repo_dir" || return
    echo "Syncing $repo_dir..." | tee -a "$LOG_FILE"
    tar -czf "$BACKUP_DIR/$(basename "$repo_dir")-backup-$(date +%F).tar.gz" .
    git fetch --all 2>&1 | tee -a "$LOG_FILE"
    git stash 2>&1 | tee -a "$LOG_FILE"
    git pull --rebase 2>&1 | tee -a "$LOG_FILE"
    git stash pop 2>&1 | tee -a "$LOG_FILE"
    git add . 2>&1 | tee -a "$LOG_FILE"
    git commit -m "Auto-sync update" 2>&1 | tee -a "$LOG_FILE"
    git push 2>&1 | tee -a "$LOG_FILE"
    echo "Sync completed for $repo_dir" | tee -a "$LOG_FILE"
}

# Function to sync all repositories
sync_all_repos() {
    for repo in "$SYNC_DIR"/*/.git; do
        repo_dir=$(dirname "$repo")
        sync_repo "$repo_dir"
    done
}

# Function to select repos to sync
select_and_sync_repos() {
    echo "Available repositories:"
    repos=()
    i=1
    for repo in "$SYNC_DIR"/*/.git; do
        repo_dir=$(dirname "$repo")
        echo "$i) $(basename "$repo_dir")"
        repos+=("$repo_dir")
        ((i++))
    done

    echo "Enter the numbers of the repos to sync (space-separated):"
    read -r selected
    for index in $selected; do
        if [[ $index =~ ^[0-9]+$ ]] && [ $index -le ${#repos[@]} ]; then
            sync_repo "${repos[$((index-1))]}"
        else
            echo "Invalid selection: $index"
        fi
    done
}

# Function to clone repos manually
clone_repos() {
    echo "Enter SSH clone URLs (one per line). Enter a blank line to finish:"
    while true; do
        read -r repo_url
        [ -z "$repo_url" ] && break
        repo_name=$(basename "$repo_url" .git)
        git clone "$repo_url" "$SYNC_DIR/$repo_name" | tee -a "$LOG_FILE"
    done
}

# Function to clone repos using GitHub API
clone_from_github_account() {
    echo "Enter your GitHub username:"
    read -r github_user
    echo "Enter your GitHub personal access token (hidden):"
    read -rs github_token
    echo

    echo "Fetching repositories for user $github_user..." | tee -a "$LOG_FILE"
    repos=$(curl -s -u "$github_user:$github_token" https://api.github.com/user/repos?per_page=100 | grep ssh_url | cut -d '"' -f 4)

    if [ -z "$repos" ]; then
        echo "No repositories found or authentication failed." | tee -a "$LOG_FILE"
        return
    fi

    echo "Select repositories to clone (space-separated numbers):"
    i=1
    urls=()
    for url in $repos; do
        echo "$i) $url"
        urls+=("$url")
        ((i++))
    done

    read -r selection
    for index in $selection; do
        if [[ $index =~ ^[0-9]+$ ]] && [ $index -le ${#urls[@]} ]; then
            url="${urls[$((index-1))]}"
            repo_name=$(basename "$url" .git)
            git clone "$url" "$SYNC_DIR/$repo_name" | tee -a "$LOG_FILE"
        else
            echo "Invalid selection: $index"
        fi
    done
}

# Function to check if SSH key exists
check_ssh_key() {
    if [ ! -f "$HOME/.ssh/id_rsa" ]; then
        echo "No SSH key found. Generating one..." | tee -a "$LOG_FILE"
        ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f "$HOME/.ssh/id_rsa" -N "" | tee -a "$LOG_FILE"
        eval "$(ssh-agent -s)"
        ssh-add "$HOME/.ssh/id_rsa"
        echo "SSH key generated. Add the following public key to your GitHub account:" | tee -a "$LOG_FILE"
        cat "$HOME/.ssh/id_rsa.pub"
        read -p "Press Enter after adding the key to GitHub..."
    fi
}

# Function to test SSH connection to GitHub
check_github_access() {
    echo "Testing SSH connection to GitHub..." | tee -a "$LOG_FILE"
    ssh -T git@github.com 2>&1 | tee -a "$LOG_FILE" | grep -q "successfully authenticated" || {
        echo "SSH connection to GitHub failed! Check your SSH setup." | tee -a "$LOG_FILE"
        exit 1
    }
}

# Run setup and checks
check_ssh_key
check_github_access

# Interactive menu
echo "Select an option:"
options=("Sync All" "Sync Selected Repos" "Sync One Repo" "Clone Repos Manually" "Clone Repos from GitHub Account" "View Log" "Exit")
select opt in "${options[@]}"; do
    case $opt in
        "Sync All")
            sync_all_repos
            ;;
        "Sync Selected Repos")
            select_and_sync_repos
            ;;
        "Sync One Repo")
            echo "Enter repository path:"
            read -r repo_path
            sync_repo "$repo_path"
            ;;
        "Clone Repos Manually")
            clone_repos
            ;;
        "Clone Repos from GitHub Account")
            clone_from_github_account
            ;;
        "View Log")
            cat "$LOG_FILE"
            ;;
        "Exit")
            break
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
done
