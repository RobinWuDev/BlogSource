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
cd ..
git add .
git commit -a -m "update blog"
git push origin master
echo "### Done"
