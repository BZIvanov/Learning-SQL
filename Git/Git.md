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
- **git push origin master** - will push the files from local repository to the remote repository. Origin is the name of the remote repository and Master is the branch from local repository from which we will push to the remote repository. If we want to push from a different branch we have to provide it's name

