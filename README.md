<p align="center" >
	<img src="/Images/logo_2048_600.png" alt="SwiftyAlgebra" title="SwiftyAlgebra">
</p>

<p align="center">
	<a href="https://swift.org">
		<img src="https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat">
	</a>
	<a href="https://cocoapods.org">
		<img src="https://img.shields.io/cocoapods/v/SwiftyAlgebra.svg">
	</a>
	<a href="https://cocoapods.org">
		<img src="https://img.shields.io/cocoapods/dt/SwiftyAlgebra.svg">
	</a>
	<a href="https://tldrlegal.com/license/mit-license">
		<img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat">
	</a>
</p>

# SwiftyAlgebra

Provides set of tools for managing numbers in Swift.

## How To Get Started

- Copy content of `Source` folder to your project.

or

- Use `SwiftyAlgebra` cocoapod

## Requirements

* iOS 9 and later
* Xcode 9 and later
* Swift 4

## Usage

Initialize new number:

```swift
let integerNumber = Number(value: 10)
let floatNumber = Number(value: 4.3)
let doubleNumber = Number(value: 9.124)
```

Check if number is integer:

```swift
let double1 = Number(value: 9.124)
double1.isInteger // false

let double2 = Number(value: 9.0)
double2.isInteger // true
```

Check if number is natural:

```swift
let int = Number(value: -20)
int1.isNatural // false

let double = Number(value: 20.0)
double.isNatural // true
```

Check if number is prime:

```swift
let int1 = Number(value: 10)
int1.isPrime // false

let int2 = Number(value: 3)
int2.isPrime // true
```

Obtain natural divisors:

```swift
let int = Number(value: 16)
let divisors = int.naturalDivisors // [1, 2, 4, 8, 16]
```

## License

`SwiftyAlgebra` is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
