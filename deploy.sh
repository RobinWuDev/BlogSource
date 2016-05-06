#! /bin/bash
hexo clean
hexo generate
echo "### Cp CNAME"
cp CNAME public/CNAME
echo "### Done"
cd public

git init
git add .
git commit -m "update at `date` "

git remote add origin https://github.com/RobinWuDev/RobinWuDev.github.io.git >> /dev/null 2>&1
echo "### Pushing to Github..."
git push origin master -f
echo "### Done"
echo "### Pushing to rsync"
/usr/local/bin/rsync  -vzrtopg --delete --exclude-from=../exclude.list . rsync@444dish.com::data --password-file=/Users/Robin/Env/rsyncd.pwd
echo "### Done"
echo "### update Source Code to Github"
cd ..
git add .
git commit -a -m "update blog"
git push origin master
echo "### Done"
