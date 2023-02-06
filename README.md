[![](https://img.shields.io/badge/iOS-16.1-critical)](#)
[![](https://img.shields.io/badge/Platforms-iPhone%20%7C%20iPad-informational)](#)
[![](https://img.shields.io/badge/Category-Utility-brightgreen)](#)

---

# MySmartRestaurant

`MySmartRestaurant` is an app that helps restaurant managers improve the management of table reservations.

The app uses a basic management view to organize table reservations through filters.
MySmartRestaurant offers the basic operations to save data both in local, using `Core Data`, and on an extarnal database, hosted with `FileMaker`.

---

## :floppy_disk: FileMaker

[![](https://img.shields.io/badge/FileMaker-info-informational)](https://www.claris.com/filemaker/)

### :door: Introduction
`FileMaker` is a cross-platform relational database application from Claris International, a subsidiary of Apple Inc. It integrates a database engine with a graphical user interface (GUI) and security features, allowing users to modify a database by dragging new elements into layouts, screens, or forms. It is available in desktop, server, iOS and web-delivery configurations. 

We developed a very small databased containing 2 tables with a relationship between them: Reservation and Table.

<img width="347" alt="Screenshot 2023-02-06 at 15 38 31" src="https://user-images.githubusercontent.com/59506453/217000725-95502e19-cfd6-4953-be24-700436e3a7dd.png">


### :calling: Communication

To perform CRUD operations on FileMaker's database, we take advantage of the `API` provided by the programme itself.
In addition, we took advantage of some of the most powerful protocols made available by the Swift language: `Codable`, `Async/Await`, `Generics`.

---

### :currency_exchange: Codable

[![](https://img.shields.io/badge/Codable-info-informational)](https://developer.apple.com/documentation/swift/codable)

`Codable` is a type that can convert itself into and out of an external representation.
Codable is a type alias for the `Encodable` and `Decodable` protocols. When you use Codable as a type or a generic constraint, it matches any type that conforms to both protocols.

We use `Codable` structures to extract data from `JSON` files and to convert yours data in `JSON` to send to FileMaker.

---

### :arrows_counterclockwise: Async/await

[![](https://img.shields.io/badge/Swift%20Concurrency-info-informational)](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)

This project uses modern and Swift built-in support `async/await` to run asynchronous and parallel code in a structured way.
_Asynchronous_ code can be suspended and resumed later, allowings your program continue to make progress on short-term operations like updating its UI while continuing to work on long-running operations like fetching data over the network or parsing files.
_Parallel_ code means multiple pieces of code run simultaneously, for example each core in a processor can run a different piece of code at the same time, completing different tasks.

 ---

### :busts_in_silhouette: Generics

[![](https://img.shields.io/badge/Swift%20Generics-info-informational)](https://docs.swift.org/swift-book/LanguageGuide/Generics.html)

`Generic` code enables you to write flexible, reusable functions and types that can work with any type.
_Generics_ are one of the most powerful features of Swift, and much of the Swift standard library is built with generic code, for example, Swift’s Array and Dictionary types are both generic collections. You can create an array that holds Int values, or an array that holds String values, or indeed an array for any other type that can be created in Swift. Similarly, you can create a dictionary to store values of any specified type, and there are no limitations on what that type can be.

In `FMProKit` this is foundamental to create a package completely detached from a particular data model allowing to work with any type and how many fields your projects need.

---
