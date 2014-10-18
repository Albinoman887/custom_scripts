#!/bin/bash
# This script will CD into each sub directory within the same folder as the xript and perform git merge tasks.
# Your git must be set up the following way for this to function
# 1: You must have a SSH key set up with github. Passing plaintext passwords is not supported
# 2: you must have a remote named "origin" which is your fork.
# 3: you must have a remote named "cm" that is the path of the main repo of your fork
# 4: assumes you are using CM 11
# NOTE: this script WILL ALWAYS DELETE the local branch its on before re-fetching and merging. This to avoid
# merge fails. DO NOT SAVE YOUR WORK IN THESE REPOS. IT WILL BE LOST!!!!!

export CURRENT_DIR=`readlink -f .`
function gitMerge()
{
    git fetch origin
    git fetch cm
    git checkout origin/cm-11.0
    git branch -D cm-11.0
    git branch cm-11.0
    git checkout cm-11.0
    git merge --no-edit cm/cm-11.0
    git push origin cm-11.0
}

for dir in $CURRENT_DIR/*; do (cd "$dir" && gitMerge); done &>fork-updater.log
