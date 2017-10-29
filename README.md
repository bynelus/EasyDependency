# EasyDependency

[![CI Status](http://img.shields.io/travis/NielsKoole/EasyDependency.svg?style=flat)](https://travis-ci.org/NielsKoole/EasyDependency)
[![Version](https://img.shields.io/cocoapods/v/EasyDependency.svg?style=flat)](http://cocoapods.org/pods/EasyDependency)
[![License](https://img.shields.io/cocoapods/l/EasyDependency.svg?style=flat)](http://cocoapods.org/pods/EasyDependency)
[![Platform](https://img.shields.io/cocoapods/p/EasyDependency.svg?style=flat)](http://cocoapods.org/pods/EasyDependency)
[![Twitter](https://img.shields.io/twitter/follow/nielskoole.svg?style=social&label=Follow)](http://twitter.com/nielskoole)

- [Installation](#installation)
- [Usage](#usage)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 4.0

## Installation

EasyDependency is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EasyDependency'
```

## Summary

EasyDependency is a very lightweight dependency injection framework, without magic. Just a container to register and resolve dependencies.
There is no focus on adding support for circular dependencies or automatic injection of dependencies. Simplicity is key.

## Features

- [x] Register & retrieve dependencies from a DI container.

## Usage

### Create dependency container

```swift
import EasyDependency

class AppContainer: Container {
    var superContainer: Container?
    var registrations: [Any] = []

    required init(container: Container? = nil) {
        self.superContainer = container
    }
}
```

### Register a dependency

This way you register an implementation on a protocol.

```swift
let appContainer = AppContainer()
appContainer.register { StorageAImpl() as Storage }
```

### Retrieve a dependency

You can retrieve the implementation by resolve the dependency by its interface.

```swift
let storageImplementation: Storage? = try? appContainer.resolve(Storage.self)
```

### Feature containers

You can create feature containers including the super container. Registrations on the feature container are used in favor of the super container.

```swift
let appContainer = AppContainer()
appContainer.register { StorageAImpl() as Storage }

let featureContainer = FeatureContainer(container: appContainer)
let storageImplementation: Storage? = try? featureContainer.resolve(Storage.self)
```

## Credits

This concept is created together with Jelle Heemskerk ([Github](https://github.com/jelleheemskerk)).

## Author

NielsKoole, niels@made2pay.com

## License

EasyDependency is available under the MIT license. See the LICENSE file for more info.

