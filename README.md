# RNNavitiaSDK [![codebeat badge](https://codebeat.co/badges/a36c43c0-d487-41e1-9da9-71c9ea65f82f)](https://codebeat.co/projects/github-com-canaltp-rnnavitiasdk-master)

React Native module for using Navitia SDK iOs &amp; Android

This is a 0.X unstable version of the SDK aimed to be used, commented, modified by anyone using it while having accepted terms of License.
Our motivation is to allow an easier and funnier experience for users who need ultimate mobility solutions for their Mobile Apps. All features are based on our Navitia open API (www.navitia.io).
Don't hesitate to get in touch with us through here or our Navitia channel (https://groups.google.com/forum/#!forum/navitia).

Team SDK @ Kisio Digital

## Installation

1. Run: `$ npm install react-native-navitia-sdk --save`
2. For each platform (iOS/Android) you plan to use, follow one of the options for the corresponding platform.

### Android

`$ react-native link`

### iOS: With [CocoaPods](https://cocoapods.org/)

> `$ react-native link` doesn't work for iOS

- Add the following to your `Podfile` and run `pod update`:

```
use_frameworks!

pod 'NavitiaSDK', '0.1'
```

- Open the `YOUR_PROJECT_NAME.xcworkspace`
- Add `RNNavitiaSDK.h` and `RNNavitiaSDK.m` from `node_modules/react-native-navitia-sdk/RNNavitiaSDK/` in your project
