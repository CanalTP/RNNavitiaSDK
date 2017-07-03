# RNNavitiaSDK [![codebeat badge](https://codebeat.co/badges/a36c43c0-d487-41e1-9da9-71c9ea65f82f)](https://codebeat.co/projects/github-com-canaltp-rnnavitiasdk-master)

React Native module for using Navitia SDK iOS &amp; Android

This is a 0.X unstable version of the SDK aimed to be used, commented, modified by anyone using it while having accepted terms of License.
Our motivation is to allow an easier and funnier experience for users who need ultimate mobility solutions for their Mobile Apps. All features are based on our Navitia open API (www.navitia.io).
Don't hesitate to get in touch with us through here or our Navitia channel (https://groups.google.com/forum/#!forum/navitia).

Team SDK @ Kisio Digital

iOS Installation
----------------

Dependencies are handled with [CocoaPods](https://cocoapods.org/), so install it first. Then install those ruby gems:

    gem install xcodeproj
    gem install json

Install the SDK in the project

    npm install react-native-navitia-sdk --save

Cocoapods will generate an Xcode workspace which will be built using the `react-native run-ios` command
    
Android installation
--------------------

    npm install react-native-navitia-sdk --save
    react-native link
