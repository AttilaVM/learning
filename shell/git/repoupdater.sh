#!/bin/bash
set -eou pipefail

repos=$(cat << EOF
EOF
)

mkdir -p ~/tmp
cd       ~/tmp

clone_repo() {
  url=$1
  name=$2
  token=$3

}

while IFS=',' read -r url name user pass token
do
  test -z "$url"  && echo 'Missing git url' > /dev/stderr && exit 1

    # download repo when its destination dir (name) does not exsist
    if [ ! -d "$name" ]
    then
      git \
        -c http.extraHeader="Authorization: Basic $(echo -n ":$token" | base64)" \
        clone "$url" "$name"
    # update repo
    else
      cd "$name"
      # track all remote branches
      while read remote_branch
      do
        local_branch="${remote_branch#origin/}"
        # skip remote branch if already exists on the local
        test -z $(git branch --list "$local_branch") || continue
        git branch --track "$local_branch" "$remote_branch"
      done < <(git branch -r | grep -v '\->')
      git \
        -c http.extraHeader="Authorization: Basic $(echo -n ":$token" | base64)" \
        fetch --all
      git \
        -c http.extraHeader="Authorization: Basic $(echo -n ":$token" | base64)" \
        pull  --all
      cd ..
    fi


done < <(echo "$repos")
