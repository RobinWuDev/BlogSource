#! /bin/bash
# hexo clean
# hexo generate
# echo "### Cp CNAME"
# cp CNAME public/CNAME
# echo "### Done"
cd public

git init
git add .
git commit -m "update at `date` "

git remote add origin https://github.com/RobinWuDev/RobinWuDev.github.io.git >> /dev/null 2>&1
echo "### Pushing blog data to Github..."
git push -f origin master
echo "### Done"
echo "### update Source Code to Github"
cd ..
git add .
git commit -a -m "update blog"
git push origin master
echo "### Done"

echo "### update theme"
cd themes/maupassant
git add .
git commit -a -m "update theme"
git push robinwu master
echo "### Done"
