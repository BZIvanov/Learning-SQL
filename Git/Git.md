# Git

We can save long inputs or common commands as aliases. If we have aliases we can find them in the global config file.

---

## Git terminology

- HEAD - it refers the currently selected / checkedout branch
- detached head - means change the HEAD from the branch to specific commit. Each commit has unique name known as hash
- hash - the specific name of each commit, that name is used to navigate through the whole tree

## Git workflow

_Working directory **->** Staging area **->** Local Repository (.git folder) **<->** Remote repository_

1. Files we have made changes on are initially in working directory. With the add command we can put them in the Staging area.
2. Files added in Staging area can be moved to the local repositoy by the commit command. Only files that have been added to the staging area can be commited to the local repository. All other changed files after that have to be added first to the staging area with the **add** command.
3. With push command files from the local repository are updated in the remote repository.

---

## Commands

### Global user

- **git config --global user.name "Biser Ivanov"** - will set the global username, which will be used when pushing to the remote repository
- **git config --global user.email "myemail@mail.com"** - will set the global e-mail, which will be used when pushing to the remote repository
- **git config --global --list** - will display the currently used username and e-mail
- **git config --global -e** - will open the default editor if we have one, should be VS code
- **git config --global core.editor "'C:/Program Files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"** - will set notepad++ as global editor for Windows. But if you have VS code it should be already your global editor so no need to run this in most cases.

### Creating new repository

- **git init my-project** - will create new repositoty locally and we can name it the way we want

### Repositoy

- **git clone git@github.com:BZIvanov/Learning-SQL-and-Git.git** - will clone remote repository, if we don't have it locally. The url is example, you can find it in GitHub. Note that this is not simple url, because this is example with using SSH key. Check how to set your SSH key if you don't have one.
- **git status** - will display the currently selected branch and the state of the repository, for example if it is up do date or commits are pending. Very often used operation to check what we need
- **git add file.txt** - will put the specified file in the staging area, where the file is ready to be commited
- **git add .** - similar to the above command, but will be applied on all files, not just the one specified. This command will add files recursively, meaning files in nested folders also
- **git commit -m "Some message text"** - will move files from staging area to the local repository, where we can proceed with pushing to the remote repository. -m stands for the message we want to provide
- **git pull origin master** - will get the remote repository and update our local repository so both are the same. It is good practice to do this operation before pushing to assure we have the latest changes
- **git push origin master** - will push the files from local repository to the remote repository. Origin is the name of the remote repository and Master is the branch from local repository from which we will push to the remote repository. If we want to push from a different branch we have to provide it's name and checkout it before that
- **git log** - will display the history of the commits
- **git log -- myfile.txt** - will log the commits, which involve only the specific file we want to check

- **git branch -a** - will display all branches. There will be an '\*', which shows the currently selected branch
- **git branch somename** - will create a new branch. By just creating it, it will not be auto selected
- **git checkout somename** - will select the branch we want to work on
- **git checkout -b somename** - will do both operations of creating a new branch and selecting it
- **git branch -m prevname newname** - will rename a branch
- **git branch -d somename** - will delete a branch. We have to select other branch before that, because we can not delete the currently used branch
- **git diff master somebranch** - will display differences between two branches. We can also compare with the remote repository in this way _git diff master origin/master_ which will compare the master branch on the local and remote repository

- **git merge somebranch** - will merge the currently selected branch with the specified in the command branch. This will do the so call fast forward merge, which require not to have commits on the current branch
- **git merge --squash some-branch-name** - while we are on master branch for example, running this command will still merge the targeted branch to the master, but the difference is that all commits on the target branch will be combined as one. This is good if we are not interested to keep history of each individual commit on branch we want to merge. And after running this command we still need to do **commit** because we are merging all commits in one.

- **git rebase master** - while we are on our different from master branch and using rebase, what will happen will be: first all commits from master will be lined together and then all commits on our currently selected branch will be lined after the commits on the master branch.
- **git rebase --abort** - if we end up in a conflict, with the abort command we go back at the point before we started rebasing. Or if we don't want to abort we can fix the conflicts in the files manually and with git status we can check if we fixed all correctly
- **git rebase --continue** - if we had conflicts and fixed them manually instead abort we can continue with the rebasing. We need to add the changes made

- **git reset --soft HEAD~1** - will reset the last commit and will keep the changes on the working tree.
- **git reset HEAD file.txt** - will remove the file from the Staging area, after we have added it there and the file will go back to working directory.
- **git checkout -- file.txt** - will undo the changes made inside the file, and the file will get back in the state where it was after the last commit
- **git checkout HEAD^** - by selecting specific commit we detached the HEAD from the branch. And by using the ^ symbol we will select the first level ancestor of the HEAD, HEAD is now the currently selected commit
- **git branch -f master HEAD~3** - will force the master branch to go back with 3 levels up in the tree

- **git mv previous-name.txt new-name.txt** - will rename the file

- **git stash save** - shorthand syntax is just git stash, because save is the default behaviour. This command will stash the changes we made and make our repo look like we never did some changes. Of course our changes will be kept in the stash. Untracked files (not previously existing in the repo) will not be included in the stash.
- **git stash save -u** - will save in stash also the Untracked files
- **git stash apply** - will give us back the changes we have stash saved previously
- **git stash list** - will list a list with all the stashes we have/made
- **git stash drop** - will remove the last stash we have. This is good to be done if we have already commited changes from the stash and we don't need the stash anymore
- **git stash show stash@{1}** - if we have more than 1 stashes we can inspect the content of one of our stashes by providing its index. We can use this kind of indexing for also other commands like drop and apply

- **git tag myTag** - this way we create the so called lightweight tag. Tags are just pointers to specific commits. Tags are created for the last commit on the current branch
- **git tag -a v-1.0 -m "Some message"** - this way we create the so called annotated tag. It is common practice to name them as versions. Annotated tags contain more information.
- **git tag --list** - will list the tags we have
- **git show myTag** - will display information about the tag
- **git tag --delete myTag** - will delete the specified tag
- **git diff someTagName anotherTagName** - will display differences between 2 tagged commits
- **git tag -a v-1.0 a8f76r -m "Some message"** - will tag specific commit by id. This is in case we dont want to tag just the last commit
- **git push origin master --tags** - will push to the remote repository all of our tags

- **git fetch origin master** - it will update the references between remote and local repository

### Tips

- HEAD - points to the last commit on the current branch
