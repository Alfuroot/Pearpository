[![](https://img.shields.io/badge/iOS-16.1-critical)](#)
[![](https://img.shields.io/badge/Platforms-iPhone%20%7C%20iPad-informational)](#)
[![](https://img.shields.io/badge/Category-Utility-brightgreen)](#)

---

# MySmartRestaurant

`MySmartRestaurant` is an app that helps restaurant managers improve the management of table reservations.

The app uses a basic management view to organize table reservations through filters.
MySmartRestaurant offers the basic operations to save data both in local, using `Core Data`, and on an extarnal database, hosted with `FileMaker`.

---

## :file_folder: FileMaker

[![](https://img.shields.io/badge/FileMaker-info-informational)](https://www.claris.com/filemaker/) <--- **Click Me!**

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
_Generics_ are one of the most powerful features of Swift, and much of the Swift standard library is built with generic code, for example, Swift’s Array and Dictionary types are both generic collections. You can create an array that holds Int values, or an array that holds String values, or indeed an array for any other type that can be created in Swift.

---

## :floppy_disk: Persistence

[![](https://img.shields.io/badge/Core%20Data-info-informational)](https://developer.apple.com/documentation/coredata)

To store data, even in the absence of a connection, we use `Core Data`, synchronising local entities with the data in the FileMaker database whenever possible.

We have implemented a customised PersistenceCotroller in order to better handle any problems that may occur during data synchronisation.
A more in-depth guide can be found in this file: [PersistenceController](https://github.com/Alfuroot/Pearpository/blob/main/PersistenceControllerTutorial.md)

---

## :department_store: App Architecture

[![](https://img.shields.io/badge/Architecture-MVVM-informational)](https://learn.microsoft.com/en-us/xamarin/xamarin-forms/enterprise-application-patterns/mvvm)

For MySmartRestaurant, we chose to implement the `Model-View-ViewModel` design pattern, since SwiftUI is designed to interact with that architecture.

There are three core components in the MVVM pattern: the `Model`, the `View`, and the `ViewModel`. Each serves a distinct purpose.
In addition to understanding the responsibilities of each component, it's also important to understand how they interact with each other. 

The benefits of using the MVVM pattern are as follows:

   - If there's an existing model implementation that encapsulates existing business logic, it can be difficult or risky to change it. In this scenario, the view model acts as an adapter for the model classes and enables you to avoid making any major changes to the model code.
    Developers can create unit tests for the view model and the model, without using the view. The unit tests for the view model can exercise exactly the same functionality as used by the view.
   - The app UI can be redesigned without touching the code, provided that the view is implemented entirely in XAML. Therefore, a new version of the view should work with the existing view model.
   - Designers and developers can work independently and concurrently on their components during the development process. Designers can focus on the view, while developers can work on the view model and model components.

The key to using MVVM effectively lies in understanding how to factor app code into the correct classes, and in understanding how the classes interact.
