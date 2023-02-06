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
