Collaborating With Git
===
# Branching

  * Try not to working directly in `master` branch, instead create new branch for each feature and working on it
  * master branch for merging from others branch and to initialize project like init code and docs
  
# Git Workflow
## Updates

  Before making any changes to `master branch`, make sure pull any updates pushed by other collaborators:
```
git checkout master
git pull origin master
```
## Resolving Merge Conflicts
A merge conflict occurs when two branches have changed the same part of the same file, and then those branches are merged together. For example, if you make a change on a particular line in a file, and your colleague working in a repository makes a change on the exact same line, a merge conflict occurs.

When this sort of conflict occurs, Git writes a special block into the file that contains the contents of both versions where the conflict occurred:
```
the number of planets are
<<<<<<< HEAD
nine
=======
eight
>>>>>>> branch-a
```
o complete this type of merge, use your text editor to resolve the conflict, then add the file and commit it to complete the merge. In this case, Git has trouble understanding which change should be used, so it asks you to help out. Refer to [this excellent github guide](https://help.github.com/articles/resolving-a-merge-conflict-from-the-command-line/) to resolve these edit merge conflicts.

## Working/Adding new features

  When you want to add new features or working on documents, we need to create a new branch to work on:
```
git checkout -b my_branch_name
```
Now changes can be locally committed to the branch:
```
git add .
git commit -am "Initial commit"
```
You can check your current branch:
```
git branch
```
When you not ready to merge to `master`, but it still recommend to push your current working branch to github so other collaborators can review your work.
You don't need to push for every commit but at least once or twice each day
```
git push -u origin new_branch_name
```
***While working on the branch, be sure to rebase with master to pull in mainline changes:***
```
git checkout master
git pull origin master
git checkout your_branch
git rebase master
```
If there are conflicts, they have to be resolved in the files and then you need to run:
```
git rebase --continue
```
until all conflicts have been resolved.




