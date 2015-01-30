#!/bin/bash

if [ -d $1 ] ; then
        cd $1
fi

if [ -f package.json ] ; then
        npm install
fi

if [ -f Gemfile ] ; then
        bundle install
fi

if [ -f composer.json ] ; then
        composer install
fi

if [ -f bower.json ] ; then
        bower install
fi

if [ -f Gruntfile.js ] ; then
        grunt staging
fi
