#!/bin/sh
#source ../../PayUParamsKit/GitHub/Version.txt 2> /dev/null
#curl -s https://github.com/payu-intrepos/payu-params-iOS/blob/main/Version.txt -o ./Version.txt
source ../../PayUParamsKit/GitHub/Version.txt

# Logs
echo "$FS_YELLOW \n==> Release Script Started $FS_DEFAULT"
cd ..

# Local Variables
podName="test"
podSpec="${podName}.podspec"
tag=$CommonUI_POD_VERSION

# Msg
SCRIPT_END_MSG="$FS_YELLOW \n==> Release Script Ended\n $FS_DEFAULT"

# Delete Local Tag
deleteLocalTag() {
    command="git tag -d $1"
    executeCommand "$command"
}

# Delete Remote Tag
deleteRemoteTag() {
    command="git push --delete origin $1"
    executeCommand "$command"
    deleteLocalTag $1
}

# Create Local Tag
createLocalTag() {
    command="git tag $1"
    executeCommand "$command"
    createRemoteTag ${tag}
}

# Create Remote Tag
createRemoteTag() {
    command="git push origin $1"
    executeCommand "$command"
    if [ $? -eq 0 ]; then
    podTrunkPush ${podSpec} $1
    else
    deleteLocalTag $1
    fi
}

# Pod Lib Lint
podLibLint() {
    repoUpdate
    command="pod lib lint $1"
    executeCommand "$command"
    if [ $? -eq 0 ]; then
    createLocalTag ${tag}
    else
    # Max count check
    if (( $3 <= 0 )); then
    echo "$FS_RED \n==> Retry Limit Exceeded. Release Aborted❗️"
    echo $SCRIPT_END_MSG
    exit 1
    fi
    # Retry
    echo "$FS_YELLOW \n==> Retrying => ${command} in seconds $2 $FS_DEFAULT"
    sleep $2
    count=$(expr $3 - 1)
    podLibLint $1 $DEFAULT_LINT_RETRY_TIME_IN_SECONDS $count
    fi
}

# Pod Trunk Push
podTrunkPush() {
    command="pod trunk push $1 --allow-warnings"
    executeCommand "$command"
    if [ $? -eq 0 ]; then
    echo "$FS_GREEN==> $podName has been released successfully.\n $FS_DEFAULT"
    else
    deleteRemoteTag $2
    echo "$FS_RED \n==> Pod Trunk Failed. Release Aborted❗️"
    echo $SCRIPT_END_MSG
    exit 1
    fi
}

# Repo Update
repoUpdate() {
    command="pod repo update"
    executeCommand "$command"
}

# Execute Command
executeCommand() {
    command=$1
    echo "$FS_YELLOW \n==> Executing => ${command} $FS_DEFAULT"
    eval "$command"
    if [ $? -eq 0 ]; then
    echo "$FS_GREEN==> Completed => ${command} $FS_DEFAULT"
    else
    echo "$FS_CYAN==> Failed => ${command} $FS_DEFAULT"
    return 1
    fi
}

# Start
podLibLint ${podSpec} $FIRST_LINT_RETRY_TIME_IN_SECONDS $MAX_RETRY_COUNT

# Logs
echo $SCRIPT_END_MSG

