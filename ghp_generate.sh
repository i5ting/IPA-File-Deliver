#! /bin/bash

if test -d ../plist_gh_pages;
  then rm -rf ../plist_gh_pages; 
fi
	
mkdir ../plist_gh_pages
cp -rf public/dist/plist ../plist_gh_pages

cd ../plist_gh_pages

git init

git remote add origin git@github.com:i5ting/IPA-File-Deliver.git
git checkout -b gh-pages

git add . 
git commit -am 'init'

git push origin gh-pages -f
