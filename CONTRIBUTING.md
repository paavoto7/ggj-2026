# How to commit?

The repository has branch protection rules activated for *main*.
To add changes, create a new branch, add your changes to it and push that to the remote repository.
Then create a pull request for it and merge, if no conflicts arise.

## On branches
Before creating a new branch from `main`, always `pull` or alternatively `fetch`.

This helps to avoid merge conflicts and creating features for old APIs etc.

If problems arise, merge or rebase main to your branch. Ask for help if needed.

## Step by step

### Getting the repo
1. Clone: `git clone https://github.com/paavoto7/ggj-2026.git` or `git clone git@github.com:paavoto7/ggj-2026.git`

### Creating a branch
1. Pull: `git pull origin main`
2. Create a branch: `git branch [branch]`
    - Or alternatively to create and checkout `git checkout -b [branch]`
3. Change branch: `git checkout [branch]`

### After adding code/assets
1. Check that no cache/config etc. files are being committed with e.g. `git status`
2. Stage: `git add [files to add or .]`
3. Commit: `git commit -m [message]`
4. Push: `git push origin [branch]`

### Adding changes to main
1. Create a pull request for your branch
2. Merge the branch, no reviewers mandated
