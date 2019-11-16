# Git

## Git workflow

*Working directory **->** Staging area **->** Repository (.git folder) **<->** Remote repository*

1. Files we have made changes on are initially in working directory. With the add command we can put them in the Staging area.
2. Files added in Staging area can me moved to the local repositoy by the commit command. Only files that have been added to the staging area can be commited to the local repository. All other changed files after that have to be added first to the staging area with the add command.
3. With push command files from the local repository are updated in the remote repository.

## Commands

### Global user

- **git config --global user.name "Biser Ivanov"** - will set the global username, which will be used when pushing to the remote repository
- **git config --global user.email "myemail@mail.com"** - will set the global e-mail, which will be used when pushing to the remote repository
- **git config --global --list** - will display the currently used username and e-mail

### Creating new repository
- **git init my-project** - will create new repositoty locally and we can name it the way we want

### Repositoy

- **git clone https://github.com/BZIvanov/Learning-SQL.git** - will clone remote repository, if we don't have it locally. The url is example, you can find it in GitHub
- **git status** - will display the currently selected branch and the state of the repository, for example if it is up do date or commits are pending. Very often used operation to check what we need
- **git add file.txt** - will put the specified file in the staging area, where the file is ready to be commited
- **git add .** - similar to the above command, but will be applied on all files, not just the one specified. This command will add files recursively, meaning files in nested folders also
- **git commit -m "Some message text"** - will move files from staging are to the local repository, where we can proceed with pushing to the remote repository. -m stands for the message we want to provide
- **git pull origin master** - will get the remote repository and update our local repository so both are the same. It is good practice to do this operation before pushing to assure we have the latest changes
- **git push origin master** - will push the files from local repository to the remote repository. Origin is the name of the remote repository and Master is the branch from local repository from which we will push to the remote repository. If we want to push from a different branch we have to provide it's name and checkout it before that
- **git log** - will display the history of the commits

- **git branch -a** - will display all branches. There will be an '*', which shows the currently selected branch
- **git branch somename** - will create a new branch. By just creating it, it will not be auto selected
- **git checkout somename** - will select the branch we want to work on
- **git checkout -b somename** - will do both operations of creating a new branch and selecting it
- **git branch -m prevname newname** - will rename a branch
- **git branch -d somename** - will delete a branch. We have to select other branch before that, because we can not delete the currently used branch
- **git diff master somebranch** - will display differences between two branches

- **git merge somebranch** - will merge the currently selected branch with the specified in the command branch. This will do the so call fast forward merge, which require not to have commits on the current branch
- **git rebase master** - while we are on our different from master branch and using rebase, what will happen will be: first all commits from master will be lined together and then all commits on our currently selected branch will be lined after the commits on the master branch.
- **git rebase --abort** - if we end up in a conflict, with the abort command we go back at the point before we started rebasing. Or if we don't want to abort we can fix the conflicts in the files manually and with git status we can check if we fixed all correctly
- **git rebase --continue** - if we had conflicts and fixed them manually instead abort we can continue with the rebasing

- **git reset HEAD file.txt** - will remove the file from the Staging area, after we have added it there and the file will go back to working directory.
- **git checkout -- file.txt** - will undo the changes made inside the file, and the file will get back in the state where it was after the last commit

- **git mv previous-name.txt new-name.txt** - will rename the file

- **git stash save** - shorthand syntax is just git stash, because save is the default behaviour. This command with stash the changes we made and make our repo look like we never did some changes. Of course our changes will be kept in the stash. Untracked files (not previously existing in the repo) will not be included in the stash.
- **git stash save -u** - will save in stash also the Untracked files
- **git stash apply** - will give us back the changes we have stash saved previously
- **git stash list** - will list a list with all the stashes we have/made
- **git stash drop** - will remove the last stash we have. This is good to be done if we have already commited changes from the stash and we don't need the stash anymore
- **git stash show stash@{1}** - if we have more than 1 stashes we can inspect the content of one of our stashes by providing its index

- **git tag myTag** - this way we create the so called lightweight tag. Tags are just pointers to specific commits. Tags are created for the last commit on the current branch
- **git tag -a v-1.0 -m "Some message"** - this way we create the so called annotated tag. It is common practice to name them as versions. Annotated tags contain more information.
- **git tag --list** - will list the tags we have
- **git show myTag** - will display information about the tag
- **git tag --delete myTag** - will delete the specified tag
- **git diff someTagName anotherTagName** - will display differences between 2 tagged commits

### Tips
- HEAD - points to the last commit on the current branch

test