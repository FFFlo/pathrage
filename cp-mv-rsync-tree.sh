#!/bin/bash

# Function to display commands
function exe() {
  resetfolders
  echo "\$ $@"
  "$@"
  showfolders
}

function resetfolders {
    rm -rf ./*
    mkdir -p a/c
    mkdir -p b/d
    touch a/c/x
    touch a/c/y
    touch a/c/.z
}

function showfolders {
    tree -aCA | head -n -1
    #ls -a -R | grep ':$' | sed -e 's/:$//' -e 's/[^\/]*\//|  /g' -e 's/|  \([^|]\)/|–– \1/g'
    #find . #-type f
    #ls **/* -l
    #du -a . | rev
    #find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/| - \1/"
    #find | sed 's|[^/]*/|- |g'
}

function runcommands () {
  arr=("$@")
    echo "-------------------------------- cp -r --------------------------------"
    for paths in "${arr[@]}"
    do
        exe cp -r $paths
    done

    echo "-------------------------------- mv --------------------------------"
    for paths in "${arr[@]}"
    do
        exe mv $paths
    done

    echo "-------------------------------- rsync -av --------------------------------"
    for paths in "${arr[@]}"
    do
        exe rsync -avq $paths
    done
}


### LETS GO ###

[[ -f output ]] && rm output
[[ ! -d test ]] && mkdir test
cd test

clear

echo "Testfolderstructure:"
resetfolders
showfolders

array=(\
"a      b" \
"a/     b" \
"a      b/" \
"a/     b/" \
"a/c    b" \
"a/c    b/" \
"a/c/   b/" \
"a/c/   b" \
"a/c/*  b/" \
"a      e" \
"a/     e" \
"a      e/" \
"a/     e/" \
"a/c    e" \
"a/c    e/" \
"a/c/   e/" \
"a/c/   e" \
"a/c/*  e/")

runcommands "${array[@]}"

echo "--------------------------------------------------"
echo "Info: 'a/c/* b/' will be shown as 'a/c/x a/c/y b/'"

rm -rf ../test
