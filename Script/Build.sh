#!/bin/sh
source ../Version.txt

build_sdk () {
    
    # Msg
    SCRIPT_END_MSG="$FS_YELLOW \n==> Build Script Ended $FS_DEFAULT"
    
    # Logs
    echo "$FS_YELLOW \n==> Build Script Started"
    echo "$FS_YELLOW \n==> Creating iOS(arm64) framework $FS_DEFAULT"
    
    # iOS framework
    var="$(xcodebuild archive \
    -project test.xcodeproj \
    -scheme $1 \
    -configuration Release \
    -destination 'generic/platform=iOS' \
    -archivePath /tmp/xcf/$1/ios.xcarchive \
    SKIP_INSTALL=NO \
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES)"
    
    # Validate iOS framework
    if ! [[ $var =~ $ARCHIVE_SUCCESS_MSG ]]; then
    echo "$FS_CYAN \n==> Failed to create iOS(arm64) framework. Please find the detailed logs below."
    echo "$FS_YELLOW \n==> Logs Start\n"
    echo "$FS_DEFAULT $var"
    echo "$FS_YELLOW \n==> Logs End\n $FS_DEFAULT"
    echo "$SCRIPT_END_MSG \n"
    exit 1
    fi
    
    # Logs
    echo "$FS_GREEN==> iOS(arm64) framework created successfully."
    echo "$FS_YELLOW \n==> Creating iOS-Simulator(arm64_x86_64) framework $FS_DEFAULT"
    
    # iOS-Simulator framework
    var="$(xcodebuild archive \
    -project test.xcodeproj \
    -scheme $1 \
    -configuration Release \
    -destination 'generic/platform=iOS Simulator' \
    -archivePath /tmp/xcf/$1/iossimulator.xcarchive \
    SKIP_INSTALL=NO \
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES)"
    
    # Validate iOS-Simulator framework
    if ! [[ $var =~ $ARCHIVE_SUCCESS_MSG ]]; then
    echo "$FS_CYAN \n==> Failed to create iOS-Simulator(arm64_x86_64) framework. Please find the detailed logs below."
    echo "$FS_YELLOW \n==> Logs Start\n"
    echo "$FS_DEFAULT $var"
    echo "$FS_YELLOW \n==> Logs End\n $FS_DEFAULT"
    echo "$SCRIPT_END_MSG \n"
    exit 1
    fi
    
    # Logs
    echo "$FS_GREEN==> iOS-Simulator(arm64_x86_64) framework created successfully."
    echo "$FS_YELLOW \n==> Creating xcframework $FS_DEFAULT"
    
    # Removing an existing xcframework if exists
    OUTPUT_DIRECTORY="./framework/$1.xcframework"
    rm -rf $OUTPUT_DIRECTORY
    
    # XCFramework
    var="$(xcodebuild -create-xcframework \
    -framework /tmp/xcf/$1/ios.xcarchive/Products/Library/Frameworks/$1.framework \
    -framework /tmp/xcf/$1/iossimulator.xcarchive/Products/Library/Frameworks/$1.framework \
    -output $OUTPUT_DIRECTORY)"
    
    # Validate xcframework
    if ! [[ $var =~ $XCFRAMEWORK_SUCCESS_MSG ]]; then
    echo "$FS_CYAN \n==> Failed to create the xcframework. Please find the detailed logs below."
    echo "$FS_YELLOW \n==> Logs Start\n"
    echo "$FS_DEFAULT $var"
    echo "$FS_YELLOW \n==> Logs End\n $FS_DEFAULT"
    echo "$SCRIPT_END_MSG \n"
    exit 1
    fi
    
    # Logs
    echo "$FS_GREEN==> XCFramework created successfully."
    echo $SCRIPT_END_MSG
    
}

# Start
cd ..
build_sdk "test"
