#!/bin/bash

set -ex

# cd script dir
cd "$(dirname "$0")" || exit

GIT_ROOT=$(pwd)

rm -rf build Payload RunCat_iOS_Demo.ipa

 xcodebuild -project "$GIT_ROOT/RunCat_iOS_Demo.xcodeproj" \
 -scheme RunCat_iOS_Demo -configuration Release \
 -derivedDataPath "$GIT_ROOT/build" \
 -destination 'generic/platform=iOS' \
 -sdk iphoneos \
 clean build \
 CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=NO \
 PRODUCT_BUNDLE_IDENTIFIER="com.powen.RunCat-iOS-Demo" \

ldid -S -M build/Build/Products/Release-iphoneos/RunCat_iOS_Demo.app
ln -sf build/Build/Products/Release-iphoneos Payload
zip -r9 RunCat_iOS_Demo.ipa Payload/RunCat_iOS_Demo.app
