#! /bin/bash
hexo clean
hexo generate
cd public

git init
git add .
git commit -m "update at `date` "

git remote add origin https://github.com/RobinWuDev/RobinWuDev.github.io.git >> /dev/null 2>&1
echo "### Pushing to Github..."
git push origin master -f
echo "### Done"
echo "### update Source Code to Github"
echo "### Pushing to rsync"
/usr/local/bin/rsync  -vzrtopg --delete . rsync@444dish.com::data --password-file=/Users/Robin/Env/rsyncd.pwd
echo "### Done"
cd ..
git add .
git commit -a -m "update blog"
git push origin master
echo "### Done"
