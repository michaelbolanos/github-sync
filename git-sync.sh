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
options=("Sync All" "Sync One Repo" "View Log" "Exit")
select opt in "${options[@]}"; do
    case $opt in
        "Sync All")
            sync_all_repos
            ;;
        "Sync One Repo")
            echo "Enter repository path:"
            read -r repo_path
            sync_repo "$repo_path"
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
