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
        git
