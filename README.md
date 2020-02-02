# EasyDependency

[![CI Status](http://img.shields.io/travis/bynelus/EasyDependency.svg?style=flat)](https://travis-ci.org/bynelus/EasyDependency)
[![Version](https://img.shields.io/cocoapods/v/EasyDependency.svg?style=flat)](http://cocoapods.org/pods/EasyDependency)
[![License](https://img.shields.io/cocoapods/l/EasyDependency.svg?style=flat)](http://cocoapods.org/pods/EasyDependency)
[![Platform](https://img.shields.io/cocoapods/p/EasyDependency.svg?style=flat)](http://cocoapods.org/pods/EasyDependency)
[![Twitter](https://img.shields.io/twitter/follow/nielskoole.svg?style=social&label=Follow)](http://twitter.com/nielskoole)

- [Installation](#installation)
- [Usage](#usage)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.1

## Installation

EasyDependency is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EasyDependency', '~> 2.0'
```

## Summary

EasyDependency is a very lightweight dependency injection framework, without magic. Just a container to register and resolve dependencies.
There is no focus on adding support for circular dependencies or automatic injection of dependencies. Simplicity is key.

## Features

- [x] Register & retrieve dependencies from a DI container.
- [x] Resolve list of implementations.
- [x] Register dependencies as singletons.
- [x] Added property wrappers for auto property injection.

## Usage

### Register a dependency

This way you register an implementation on a protocol.

```swift
try DISharedContainer.register(Storage.self) { _ in StorageAImpl() }
try DISharedContainer.register(Storage.self) { _ in StorageBImpl() }
try DISharedContainer.register(Storage.self, .lazySingleton) { _ in StorageBImpl() }
```

### Retrieve a dependency

You can retrieve the implementation by resolve the dependency by its interface.

```swift
let storage: Storage = try appContainer.resolve()
let storageList: [Storage] = try appContainer.resolve()
let storage: Storage? = try? (appContainer.resolve() as Storage)
```

## Credits

This concept is created together with Jelle Heemskerk ([Github](https://github.com/jelleheemskerk)).
Also credits to Quentin Jin for creating [Schedule](http://https://github.com/luoxiu/Schedule), a very elegant and intuïtive way of scheduling jobs.

## Author

NielsKoole ([Twitter](https://twitter.com/nielskoole))

## License

EasyDependency is available under the MIT license. See the LICENSE file for more info.

