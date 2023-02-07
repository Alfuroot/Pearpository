# Why create a custom persitence controller

Using auto generated code from coreData is easy but it doesn't give a lot of space to customize its code and edit functions. That why we decided to create
our personal persistence controller.

# Persistence controller creation

In order to do it, create a new file and create a struct like this: 

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

To call the persistence controller in your app, since we declared a singleton, we will just have to write something like:
```swift
    PersistenceController.shared.`functionName()`
```
Then, you will want to add a save funcion in order to keep changes on your data

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
    
```

And finally, we can define fetch, create and delete functions: 

```swift

    func fetchFromCoreDataEntity() -> [myClass] {
    
        // Defining request
        let request = NSFetchRequest<myCoreDataEntity>(entityName: "myCoreDataEntity")
        
        // Here you could define request.predicate
        
        //creating an array of entities fetched from coreData
        let entities = try? container.viewContext.fetch(request)
        
        
        if let entities = entities {
            let list = entities.map {
                
                Table(coreDataEntity: $0)
            }
            return list
        }
        return []
    }
    
    func saveInCoreDataEntity(myObject: MyClass) {
        
        // Creating a new entity
        let myEntity = myCoreDataEntity(context: container.viewContext)
        
        myObject.copyInEntity(coreDataEntity: myEntity)
        
        // Saving of the new entity in CoreData
        try? container.viewContext.save()
    }
    
    func deleteAllFromCoreDataEntity() {
        
        // Define which entities to delete from coreData (we could also filter them with a predicate)
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "myCoreDataEntity")
        
        // Define the delete request
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.code)
        }
    }
    
```
You could add predicates to the deleteRequest and fetchRequest in order to filter data.
