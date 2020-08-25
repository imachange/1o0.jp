#!/bin/sh
git submodule foreach git stash
git submodule foreach git checkout master
git submodule foreach git pull --allow-unrelated-histories origin master
