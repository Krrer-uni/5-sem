#!/usr/bin/bash

svn checkout $3 --depth empty
cd $(ls -td */ | head -1)
git init
echo .svn >> .gitignore
for i in $(seq $1 $2)
do
svn checkout -r $i $3 
git add .
git commit -m "$(svn log -r $i $3 --xml | sed -n '/<msg>/,/<\/msg>/p' | head -c-7 | tail -c+6)"
done
cd ..

    
