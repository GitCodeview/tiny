# Command line instructions

## Git local setup
```
git config user.name "linyuqing"
git config user.email "yqlin@stl"
```
## Create a new repository
```
git clone git@192.168.2.24:yqlin/git-test.git
cd git-test
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```
## Existing folder
```
cd existing_folder
git init
git remote add origin git@192.168.2.24:yqlin/git-test.git
git add .
git commit -m "Initial commit"
git push -u origin master
```

## Existing Git repository
```
cd existing_repo
git remote add origin git@192.168.2.24:yqlin/git-test.git
git push -u origin --all
git push -u origin --tags
```