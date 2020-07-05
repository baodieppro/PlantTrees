# PlantTrees iOS

All the credits go to DuckDuckGo
https://github.com/duckduckgo/iOS

![image](https://i.imgur.com/pjsES8s.png)

## Building

### Submodules
We use submodules, so you will need to bring them in to the project in order to build and run it:

Run `git submodule update --init --recursive`

### Dependencies
We use Carthage for dependency management. If you don't have Carthage installed refer to [Installing Carthage](https://github.com/Carthage/Carthage#installing-carthage).

Run `carthage bootstrap --platform iOS`

You can also run the unit tests to do the above and ensure everything seems in order: `./run_tests.sh`

Since there is no offical Carthage package for Firebase, I used Cocoapods for firebase.

Run `pod install` and open workspace generated in Xcode

### SwiftLint
SwiftLint disabled for now

### Instruments

We have Custom Instruments tool to help visualize and track events that happen during runtime.

In order to run it:
1. Build a Debug version and install it on Simulator/Device.
2. Select Instruments target and run it on a Mac. New instance of Instruments app will be run that has a grayed out icon indicating that it works in debug mode with custom instruments attached.
3. Select 'DDG Trace' template or setup a custom one by importing 'DDG Timeline' instrument from Library .
4. Start recording.

See [Instruments Developer Help](https://help.apple.com/instruments/developer/mac/current/) for reference how to create custom instruments.

## Terminology

We have taken steps to update our terminology and remove words with problematic racial connotations, most notably the change to `main` branches, `allow lists`, and `blocklists`. Closed issues or PRs may contain deprecated terminology that should not be used going forward.

## License
DuckDuckGo is distributed under the Apache 2.0 [license](https://github.com/duckduckgo/ios/blob/master/LICENSE).


