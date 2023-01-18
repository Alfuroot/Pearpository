//
//  Persistence Controller.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 18/01/23.
//

import Foundation
import CoreData

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
    
    func fetchLocalTables() -> [Table] {
        let request = NSFetchRequest<CoreTable>(entityName: "CoreTable")
        
        let tableEntities = try? container.viewContext.fetch(request)
        
        
        if let tableEntities = tableEntities {
            let list = tableEntities.map {
                
                Table(coreDataEntity: $0)
            }
            return list
        }
        return []
    }
    
    func saveNewTable(_ table: Table) {
        
        // Creating a new entity
        let tableEntity = CoreTable(context: container.viewContext)
        
        table.copyInEntity(coreDataEntity: tableEntity)
        
        // Saving of the new entity in CoreData
        try? container.viewContext.save()
    }
    
    func deleteAllTables() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CoreTables")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.code)
        }
    }
    
    func saveNewReservation(_ reservation: Reservation, _ table: String) {
        
        // Creating a new entity
        let reservationEntity = CoreReservation(context: container.viewContext)
        
        let request = NSFetchRequest<CoreTable>(entityName: "CoreTable")
        
        reservation.copyInEntity(coreDataEntity: reservationEntity)
        
        //            Saving of the new entity in CoreData
        try? container.viewContext.save()
    }
}
