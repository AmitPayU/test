#!/bin/sh
source ../../PayUParamsKit/GitHub/Version.txt

# Logs
echo "$FS_YELLOW \n==> Git Script Started $FS_DEFAULT"
cd ../GitHub

# add
command="git add ."
echo "$FS_YELLOW\n==> Executing => ${command} $FS_DEFAULT"
eval "$command"

# commit
command="git commit -m\"$CommonUI_COMMIT_MESSAGE\""
echo "$FS_YELLOW\n==> Executing => ${command} $FS_DEFAULT"
eval "$command"

# push
command="git push"
echo "$FS_YELLOW\n==> Executing => ${command} $FS_DEFAULT"
eval "$command"

if ! [ $? -eq 0 ]; then
exit 1
fi

# Logs
echo "$FS_YELLOW \n==> Git Script Ended $FS_DEFAULT"

