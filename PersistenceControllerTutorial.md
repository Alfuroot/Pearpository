# Why create a custom persitence controller

Using auto generated code from coreData is easy but it doesn't give a lot of space to customize its code and edit functions, that why we decided to create
our personal persistence controller.

# Persistence controller creation

In order to do it create a new file and create a struct like this: 

```swift

struct PersistenceController {
    // A singleton for our entire app to use
    static let shared = PersistenceController()
    
    // Storage for Core Data
    let container: NSPersistentContainer
    
    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    private init() {
        container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error: \(error)")
            }
        }
    }
}

```

To call the persistence controller in your app since we declared a singleton we will just have to write something like:
```swift
    PersistenceController.shared.`functionName()`
```
Then you will want to add a save funcion in order to keep changes on your data

```swift

func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
    


