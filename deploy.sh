#!/bin/bash

git config --global user.name "jaejin1"
git config --global user.email opiximeo@gmail.com

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo -t LoveIt

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ..


# blog 저장소 Commit & Push
git add .

msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push origin master

git config --global user.name "jaejin-flo"
git config --global user.email jaejin@dreamus.io