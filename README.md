# GitHub Sync Script

## Overview

`github-sync.sh` is a powerful and interactive Bash script that automates syncing and managing Git repositories under your `~/scripts` directory. It helps you stay in sync with GitHub through SSH authentication, GitHub API integration, and an interactive menu.

---

## Features

- ✅ **SSH Key Setup** – Generates an SSH key if missing and prompts you to add it to GitHub.
- 🔁 **Auto-Sync Repos** – Automatically fetches, stashes, pulls, commits, and pushes repos.
- 🌐 **GitHub API Integration** – Uses your GitHub token to fetch and clone all your repos.
- 📦 **Auto Backup** – Archives each repo before syncing.
- 🎨 **Color UI + Alerts** – Color-coded output with terminal sound notifications.
- 🔍 **Interactive Menu** – Sync all, selected, or one repo; clone manually or via API.
- 📜 **Logging** – All actions logged to `~/scripts/github-sync.log`.

---

## Prerequisites

- ✅ Linux/macOS terminal with Bash
- ✅ `git`, `curl`, and `ssh` installed
- ✅ GitHub account

---

## First-Time Setup (SSH + Token)

### 🔑 1. Generate an SSH Key (script does this if missing)
```bash
ssh-keygen -t rsa -b 4096 -C "you@example.com"
```

### 🔗 2. Add SSH Key to GitHub

Copy your public key:
```bash
cat ~/.ssh/id_rsa.pub
```

Then go to: [https://github.com/settings/keys](https://github.com/settings/keys)  
Click **New SSH key**, paste it in, and save.

### 🔐 3. Create GitHub Personal Access Token (for API)

Go to: [https://github.com/settings/tokens](https://github.com/settings/tokens)

Click **Generate new token (classic)**  
✅ Select scopes:
- `repo`
- `read:user`

Copy the token (you’ll need it for the script's "Clone from GitHub Account" option).

---

## Installation

```bash
git clone git@github.com:michaelbolanos/github-sync.git
cd github-sync
chmod +x github-sync.sh
```

Optional (run globally):

```bash
sudo mv github-sync.sh /usr/local/bin/github-sync
```

---

## Usage

```bash
./github-sync.sh
```

Or globally:

```bash
github-sync
```

---

## Menu Options

1. **Sync All** – Sync all repos in `~/scripts`
2. **Sync Selected Repos** – Pick specific ones to sync
3. **Sync One Repo** – Enter a path manually
4. **Clone Repos Manually** – Paste SSH URLs one by one
5. **Clone from GitHub Account** – Enter GitHub username and token to clone and sync all repos
6. **View Log** – Show sync logs
7. **Exit** – Exit script

---

## Merge Conflict Handling

If you see:

```
⚠️ Merge conflict detected! Resolve manually and re-run the script.
```

Run:
```bash
git status
git mergetool
git rebase --continue
```

Then re-run the script.

---

## License

MIT License – see `LICENSE`.

---

## Contributions

Fork the repo, suggest changes, and submit PRs.

---
