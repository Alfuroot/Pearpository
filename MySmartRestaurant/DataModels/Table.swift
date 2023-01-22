//
//  Table.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 11/01/23.
//

import Foundation

public class Table: Codable {
    var id: Int?
    var isReservedLunch: String?
    var isReservedDinner: String?
    var isOutdoor: String?
    
    
    init(tableName: Int, isOutdoor: String) {
        self.id = tableName
        self.isReservedLunch = "false"
        self.isReservedDinner = "false"
        self.isOutdoor = isOutdoor
    }
    
    init(coreDataEntity: CoreTable) {
        self.id = Int(coreDataEntity.id)
        self.isReservedLunch = String(coreDataEntity.isReservedLunch)
        self.isReservedDinner = String(coreDataEntity.isReservedDinner)
        self.isOutdoor = String(coreDataEntity.isOutdoor)
    }
    
    func copyInEntity(coreDataEntity: CoreTable) {
        coreDataEntity.id = Int16(self.id ?? 0)
        coreDataEntity.isReservedLunch = (self.isReservedLunch)?.boolValue ?? false
        coreDataEntity.isReservedDinner = (self.isReservedDinner)?.boolValue ?? false
        coreDataEntity.isOutdoor = (self.isOutdoor)?.boolValue ?? false
    }
}

extension String {
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}
