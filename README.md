## MyParentsOnBoard

[![Build Status](https://travis-ci.org/ajilo297/my-parents-on-board.svg?branch=master)](https://travis-ci.org/ajilo297/my-parents-on-board)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=my-parents-on-board&metric=alert_status)](https://sonarcloud.io/dashboard?id=my-parents-on-board)

##### Current CICD steps
1. Run XCode test with 
```sh
xcodebuild clean test -workspace MyParentsOnBoard.xcworkspace -scheme MyParentsOnBoard -destination "platform=iOS Simulator,name=iPhone 8,OS=12.1" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=NO -quiet
```
2. Code quality analysis with SonarQube
