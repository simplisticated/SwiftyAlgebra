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

### Introduction to Numbers

Instead of using many separate primitive numeric types, `SwiftyAlgebra` uses a universal type named `Number` which is working with all primitive types like `Double` values under the hood. The `Number` class is highly compatible with primitive types and currently supports:

- `Int`
- `Float`
- `Double`

Initializing new number is pretty simple:

```swift
let integerNumber = Number(value: 10)

let someFloatValue: Float = 4.3
let floatNumber = Number(value: someFloatValue)

let doubleNumber = Number(value: 9.124)
```

Also, you can get primitive value back easily:

```swift
let number = Number(value: 9.124)
number.int // 9
number.float // 9.124
number.double // 9.124
```
### Integer numbers

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

### Operators

One `Number` can be easily added to another:

```swift
let ten = Number(value: 10)
let two = Number(value: 2)
let sum = ten + two
sum.int // 12
```

In purpose of better compatibility with primitive numeric types, `SwiftyAlgebra` provides set of operators that might be helpful when you need to use `Number` and primitive variable in the same expression:

```swift
let number = Number(value: 10) + 2
number.int // 12
```

Full list of supported operators:

<table style="width: 100%">
	<tr>
		<th>
			Left Type
		</th>
		<th>
			Operator
		</th>
		<th>
			Right Type
		</th>
		<th>
			Example
		</th>
	</tr>
	<tr>
		<th colspan="4">
			Addition
		</th>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			+
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				Number(value: 10) + Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			+
		</td>
		<td>
			Int
		</td>
		<td>
			<code>
				Number(value: 10) + 2
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			+
		</td>
		<td>
			Float
		</td>
		<td>
			<code>
				Number(value: 10) + 2.0
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			+
		</td>
		<td>
			Double
		</td>
		<td>
			<code>
				Number(value: 10) + 2.0
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Int
		</td>
		<td>
			+
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				10 + Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Float
		</td>
		<td>
			+
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				10.0 + Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Double
		</td>
		<td>
			+
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				10.0 + Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<th colspan="4">
			Subtraction
		</th>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			-
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				Number(value: 10) - Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			-
		</td>
		<td>
			Int
		</td>
		<td>
			<code>
				Number(value: 10) - 2
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			-
		</td>
		<td>
			Float
		</td>
		<td>
			<code>
				Number(value: 10) - 2.0
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			-
		</td>
		<td>
			Double
		</td>
		<td>
			<code>
				Number(value: 10) - 2.0
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Int
		</td>
		<td>
			-
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				10 - Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Float
		</td>
		<td>
			-
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				10.0 - Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Double
		</td>
		<td>
			-
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				10.0 - Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<th colspan="4">
			Multiplication
		</th>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			*
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				Number(value: 10) * Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			*
		</td>
		<td>
			Int
		</td>
		<td>
			<code>
				Number(value: 10) * 2
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			*
		</td>
		<td>
			Float
		</td>
		<td>
			<code>
				Number(value: 10) * 2.0
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			*
		</td>
		<td>
			Double
		</td>
		<td>
			<code>
				Number(value: 10) * 2.0
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Int
		</td>
		<td>
			*
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				10 * Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Float
		</td>
		<td>
			*
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				10.0 * Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Double
		</td>
		<td>
			*
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				10.0 * Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<th colspan="4">
			Division
		</th>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			/
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				Number(value: 10) / Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			/
		</td>
		<td>
			Int
		</td>
		<td>
			<code>
				Number(value: 10) / 2
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			/
		</td>
		<td>
			Float
		</td>
		<td>
			<code>
				Number(value: 10) / 2.0
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Number
		</td>
		<td>
			/
		</td>
		<td>
			Double
		</td>
		<td>
			<code>
				Number(value: 10) / 2.0
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Int
		</td>
		<td>
			/
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				10 / Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Float
		</td>
		<td>
			/
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				10.0 / Number(value: 2)
			</code>
		</td>
	</tr>
	<tr>
		<td>
			Double
		</td>
		<td>
			/
		</td>
		<td>
			Number
		</td>
		<td>
			<code>
				10.0 / Number(value: 2)
			</code>
		</td>
	</tr>
</table>

## License

`SwiftyAlgebra` is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
