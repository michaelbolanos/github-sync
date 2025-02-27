# GitHub Sync Script

![GitHub Sync](https://img.shields.io/badge/version-1.0-blue.svg) ![License](https://img.shields.io/badge/license-MIT-green.svg)

## 📌 Overview

**github-sync.sh** is a simple yet powerful Bash script designed to streamline the synchronization of Git repositories located under the `~/scripts` directory. This script automates the process of fetching, stashing, pulling, and pushing changes to GitHub, ensuring that your local and remote repositories remain up to date with minimal effort.

## 🚀 Features

- 📂 **Automatic Repository Discovery:** Scans the specified directory for Git repositories.
- ⏳ **Interactive Selection with Timeout:** Prompts the user to select a repository within 14 seconds, defaulting to `~/scripts`.
- 🔄 **Automated Syncing:** Fetches the latest changes, handles stashing of local modifications, and rebases changes from GitHub.
- 🛠 **Conflict Handling:** Detects merge conflicts and prompts the user to resolve them manually.
- 📌 **Auto-Commit & Push:** Stages and commits any new changes before pushing them to the remote repository.
- 🔒 **Error Handling:** Provides meaningful feedback in case of invalid selections or Git errors.

## 🏗 Prerequisites

Ensure you have the following installed on your system:

- 🐧 **Linux/macOS** (Compatible Bash environment)
- 🔧 **Git** (Ensure you have SSH authentication set up for GitHub)

## 📥 Installation

1. **Clone the Repository:**
   ```bash
   git clone git@github.com:michaelbolanos/github-sync.git
   ```
2. **Make the Script Executable:**
   ```bash
   chmod +x github-sync.sh
   ```
3. **Move to a Global Location (Optional):**
   ```bash
   sudo mv github-sync.sh /usr/local/bin/github-sync
   ```
   Now you can run it from anywhere using:
   ```bash
   github-sync
   ```

## 🔄 Usage

Run the script with:
```bash
./github-sync.sh
```
or if installed globally:
```bash
github-sync
```

### Step-by-Step Execution:
1. **Select a directory** (defaults to `~/scripts` if no input is provided within 14 seconds).
2. **Choose a repository** from the detected list.
3. **Sync process starts**:
   - Fetches the latest changes from the remote repository.
   - Detects and stashes any local modifications.
   - Rebases with the latest remote changes.
   - Re-applies stashed changes (if applicable).
   - Stages, commits, and pushes any new local changes.
4. **Completion message** confirming a successful sync or warning of conflicts if they arise.

## ⚠️ Handling Merge Conflicts

If a merge conflict occurs, the script will notify you:

```bash
⚠️ Merge conflict detected! Manually resolve and re-run the script.
```
Resolve conflicts manually using:
```bash
git status
git mergetool
git rebase --continue
```
Once resolved, re-run the script to complete the sync process.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

- **Michael Bolanos**  
  🚀 [GitHub](https://github.com/michaelbolanos)  
  🌐 [Website](https://github.com/michaelbolanos/github-sync)

## 🤝 Contributions

Contributions are welcome! Feel free to fork the repo and submit pull requests.

---

🚀 **Keep your repositories in sync effortlessly!**

