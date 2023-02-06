//
//  Table.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 11/01/23.
//

import Foundation

public class Table: Codable {
    var id: Int?
    var isOutdoor: String?
    
    // To Create an Object
    init(tableName: Int, isOutdoor: String) {
        self.id = tableName
        self.isOutdoor = isOutdoor
    }
    
    // To retrieve data from coredata
    init(coreDataEntity: CoreTable) {
        self.id = Int(coreDataEntity.id)
        self.isOutdoor = String(coreDataEntity.isOutdoor)
    }
    
    // Save in CoreData
    func copyInEntity(coreDataEntity: CoreTable) {
        coreDataEntity.id = Int16(self.id ?? 0)
        coreDataEntity.isOutdoor = (self.isOutdoor)?.boolValue ?? false
    }
}

// To convert String from FileMaker to Bool
extension String {
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}
