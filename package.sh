#!/bin/sh

easy_install3 py3-ortools

rm -rf dist dist.zip; mkdir dist

find "/opt/python3/lib/python3.6/site-packages" -path "*.egg/*" -not -name "EGG-INFO" -maxdepth 2 -exec cp -r {} ./dist \;
find -not -name 'dist' -not -name 'Dockerfile' -not -name 'package.sh' -mindepth 1 -maxdepth 1 -exec cp -r {} ./dist \;

chmod -R 755 ./dist

cd dist; zip -r ../dist.zip *