#!/bin/bash

# generate code coverage in local ./Build directory
xcodebuild -project standard-swift.xcodeproj/ -scheme standard-swift \
    -derivedDataPath Build/ \
    -destination 'platform=iOS Simulator,OS=13.4.1,name=iPhone 8' \
    -enableCodeCoverage YES clean build test \
    CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO

# Install slather
if ! which slather >/dev/null 2>&1; then \
    echo "install slather"; \
    gem install slather
fi

# slather will search local .slather.yml config file
# the xml format report will be in local ./report dir
slather coverage -b Build/

# Here is the command to upload xml format report to codecov.io
# curl -s https://codecov.io/bash  -t {YOUR-TOKEN-HERE}  -J 'standard-swift'

