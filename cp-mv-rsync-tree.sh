#!/bin/bash

# Function to display commands
function exe() {
  echo "\$ $@"
  resetfolders
  "$@"
  showfolders
}

[[ ! -d test ]] && mkdir test
cd test

function resetfolders {
    rm -rf ./*
    mkdir -p a/c
    mkdir -p b/d
    touch a/c/x
    touch a/c/y
    touch a/c/.z
}

function showfolders {
    tree -a | head -n -1
    #find . #-type f
    #ls **/* -l
    #du -a . | rev
    #find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/| - \1/"
    #find | sed 's|[^/]*/|- |g'
}

function runcommands () {
  arr=("$@")
    for paths in "${arr[@]}"
    do
        exe cp -r $paths
    done

    for paths in "${arr[@]}"
    do
        exe mv $paths
    done

    for paths in "${arr[@]}"
    do
        exe rsync -avq $paths
    done
}


### LETS GO ###
clear

echo "Testfolderstructure:"
showfolders

array=(\
"a      b" \
"a/     b" \
"a/     b/" \
"a/c    b" \
"a/c    b/" \
"a/c/   b/" \
"a/c/*  b/")

runcommands "${array[@]}"

