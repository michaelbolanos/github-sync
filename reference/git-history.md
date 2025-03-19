# Git Branching & Merging

## History & Context of Git and GitHub

### Git: The Foundation of Modern Version Control
Git is a distributed version control system (VCS) created by **Linus Torvalds** in 2005. It was developed as a **fast, scalable, and decentralized** system to manage the Linux kernel's massive codebase. Before Git, the Linux community relied on **BitKeeper**, a proprietary VCS, which was later revoked, prompting Torvalds to develop a **free, open-source** alternative.

#### Key Features of Git:
- **Distributed Nature** – Every developer has a complete copy of the repository.
- **Fast Performance** – Optimized for high-speed branching, merging, and committing.
- **Branching & Merging** – Lightweight and flexible branching system.
- **Data Integrity** – Uses **SHA-1 hashing** to ensure data integrity.
- **Collaboration** – Allows multiple contributors to work without conflicts.

### ☁️ GitHub: Bringing Git to the Cloud
GitHub was launched in **2008** by **Tom Preston-Werner, Chris Wanstrath, and PJ Hyett** as a **cloud-based** Git hosting service. It quickly became the dominant platform for hosting open-source and private repositories, surpassing alternatives like GitLab and Bitbucket.

#### Why GitHub Became Popular:
- **Web-based Git Interface** – Provides an intuitive graphical user interface.
- **Collaboration Tools** – Features like **pull requests, issues, discussions, and CI/CD workflows** help streamline development.
- **Community & Open Source** – The largest open-source ecosystem.
- **Integration with DevOps** – Works seamlessly with CI/CD pipelines and automation tools.

GitHub played a major role in making **version control and open-source collaboration mainstream**, enabling millions of developers to contribute to projects worldwide.

---

## 🌿 What is a Git Branch?
A Git branch is a **lightweight pointer** to a specific commit in the repository. It allows you to isolate work on different tasks or features without affecting the main branch.

### 💡 Key Benefits of Branching:
- Work on new features without disrupting the main project.
- Experiment with changes before merging them into production.
- Keep the `main` or `master` branch stable.
- Facilitate collaboration among multiple developers.

### 🌱 Basic Branching Commands
```bash
# List all branches
git branch

# Create a new branch
git branch new-feature

# Switch to a branch
git checkout new-feature
# OR (recommended)
git switch new-feature

# Create and switch to a branch in one step
git checkout -b another-feature
# OR
git switch -c another-feature

# Delete a local branch
git branch -d branch-name

# Delete a remote branch
git push origin --delete branch-name
```

---

## 🔄 Merging: Combining Changes from Different Branches
Once work on a branch is completed, you can **merge** it back into the main branch. Git provides different ways to merge branches.

### 🔗 Fast-Forward Merge (Default)
Occurs when the branch being merged is ahead of the main branch with no divergence.

```bash
git checkout main
git merge new-feature
```

### 📌 Three-Way Merge
Occurs when two branches have diverged, and Git needs to create a new commit to reconcile changes.

```bash
git checkout main
git merge another-feature
```

---

## 🔀 Merge Conflicts
If two branches modify the same lines of a file differently, Git cannot automatically merge them.

#### Steps to Resolve a Conflict:
```bash
git merge branch-name
# Git will show a conflict
git status
# Manually edit the conflicted files
git add filename.txt
git commit -m "Resolved merge conflict"
```

---

## 🌊 Rebase: A Cleaner Alternative to Merging
Rebasing **reapplies commits on top of another base branch**, creating a cleaner history.

```bash
git checkout feature
git rebase main
```

### 🌊 When to Use Rebase vs Merge
| **Scenario** | **Use Merge** | **Use Rebase** |
|-------------|--------------|--------------|
| Keeping a feature branch updated | ✅ | ✅ |
| Preserving commit history | ✅ | ❌ |
| Creating a clean linear history | ❌ | ✅ |
| Avoiding unnecessary merge commits | ❌ | ✅ |

---

## 🚀 Advanced Branching Strategies
### 1️⃣ Feature Branch Workflow
Each feature is developed in a separate branch and merged back when complete.

```bash
git checkout -b feature-login
# Work on the feature
git add .
git commit -m "Implemented login feature"
git checkout main
git merge feature-login
git push origin main
```

### 2️⃣ Gitflow Workflow
A structured branching model for teams:
- `main` → Stable production code
- `develop` → Active development
- `feature/branch-name` → New features
- `release/branch-name` → Release preparation
- `hotfix/branch-name` → Urgent bug fixes

### 3️⃣ Trunk-Based Development
- Developers work directly on a **single shared branch** (`main`).
- Small, incremental commits are made frequently.
- Feature flags are used instead of long-lived branches.

---

## 📚 Hands-On Practice
Try out these commands in a test repo:
```bash
git init test-repo
cd test-repo
echo "Hello Git" > file.txt
git add file.txt
git commit -m "Initial commit"

# Create and merge branches
git branch feature-1
git switch feature-1
echo "Feature 1 Work" >> file.txt
git add file.txt
git commit -m "Added feature 1"
git switch main
git merge feature-1
```

---

## 🎯 Summary
| **Command** | **Purpose** |
|------------|------------|
| `git branch new-feature` | Create a new branch |
| `git checkout new-feature` | Switch to a branch |
| `git merge branch-name` | Merge changes from another branch |
| `git rebase branch-name` | Reapply commits onto another branch |
| `git branch -d branch-name` | Delete a branch |
| `git push origin --delete branch-name` | Delete a remote branch |

---

