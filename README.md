# GitHub Sync Script

## Overview

`github-sync.sh` is a powerful and interactive Bash script designed to manage and synchronize Git repositories under your `~/scripts` directory. It offers smart automation for cloning, syncing, stashing, committing, pushing, and even setting up your GitHub SSH credentials. The script provides a menu-driven interface with color-coded output and alerts, making it user-friendly and efficient for developers and sysadmins.

---

## Features

- ✅ **Auto SSH Setup** – Generates and installs SSH keys if missing, then checks access.
- 🔁 **Auto-Sync Repos** – Scans `~/scripts` and automatically syncs all Git repos.
- 🎯 **Interactive Menu** – Lets you sync all, selected, or single repos.
- 🌐 **GitHub Integration** – Uses GitHub API to list and clone all repos in your account.
- 🔒 **SSH-Based Git Pull/Push** – Operates securely with your GitHub SSH key.
- 💾 **Auto Backup** – Creates a `.tar.gz` backup before each sync.
- 🧠 **Conflict Detection** – Alerts if a merge conflict occurs.
- 🧹 **Error Handling** – Gives clear messages and log feedback.
- 🎨 **Color Output + Alerts** – Highlights statuses and plays terminal sound on completion.
- 📜 **Detailed Logging** – Outputs all actions to `~/scripts/github-sync.log`.

---

## Prerequisites

- ✅ Linux or macOS with Bash
- ✅ Git installed
- ✅ SSH access to GitHub (script sets this up if needed)
- ✅ `curl` for API access

---

## Installation

```bash
git clone git@github.com:michaelbolanos/github-sync.git
cd github-sync
chmod +x github-sync.sh
```

Optional (run script globally):

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

1. **Sync All** – Auto syncs all Git repos in `~/scripts`
2. **Sync Selected Repos** – Choose which ones to sync
3. **Sync One Repo** – Provide one path manually
4. **Clone Repos Manually** – Paste SSH URLs to clone
5. **Clone from GitHub Account** – Auto fetch + sync all your GitHub repos
6. **View Log** – View full sync history
7. **Exit** – Quit the script

---

## GitHub Access Token

For Option 5, generate a token here:  
👉 [https://github.com/settings/tokens](https://github.com/settings/tokens)

Select scopes:
- `repo`
- `read:user`

---

## Merge Conflict Handling

If a conflict occurs:

```
⚠️ Merge conflict detected! Resolve manually and re-run the script.
```

Fix using:

```bash
git status
git mergetool
git rebase --continue
```

Then re-run the script.

---

## License

MIT License – see the LICENSE file.

---

## Contributions

Fork and submit pull requests anytime. Suggestions and improvements are welcome!

---
