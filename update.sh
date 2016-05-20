#!/bin/sh

if [ $# -ne 1 ]
then
    echo Usage: $0 version
    exit 1
fi

VERSION=$1

echo $VERSION | grep -e "^[0-9]\+\.[0-9]\+\.[0-9]\+$"
if [ $? -ne 0 ]
then
    echo 'Version must be like "xx.xx.xx"'
    exit 2
fi

git checkout master || exit 3

sed -i Dockerfile -e "s/DodontoF_Ver\.[0-9]\+\.[0-9]\+\.[0-9]\+\.zip/DodontoF_Ver.$VERSION.zip/g"

git add Dockerfile || exit 3
git commit -m "v$VERSION" || exit 3

git tag "v$VERSION" || exit 3
git push || exit 3

git checkout nginx || exit 3
git cherry-pick master || exit 3
git tag "v$VERSION-nginx" || exit 3
git push || exit 3

git checkout master || exit 3
git push --tags || exit 3
