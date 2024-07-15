git status

read -p "Do you wish to add these files to stage? (y/n): " proceed

[ $proceed == "n" ] && exit 1 || git add . 

echo "Type Commit Message. Ctrl+D to signal end of input..."

msg=$(cat)

read -p "Commit The current staged changes? (y/n): " proceed

[ $proceed == "n" ] && exit 1 || git commit -m "$msg"


feature_branch=`git branch --no-color | grep -E '^\*' | awk '{print $2}'`

git checkout development
git pull origin development
git merge --no-ff $feature_branch
git push origin development

read -p "Do you wish to delete Feature branch: $feature_branch:(y/n) " proceed

[ $proceed == "n" ] && exit 0 ||  git branch -d $feature_branch

echo "Done!!!"

