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
    
    
    init(tableName: Int) {
        self.id = tableName
    }
    
    init(coreDataEntity: CoreTable) {
//        self.id = coreDataEntity.tableName
    }
    
    func copyInEntity(coreDataEntity: CoreTable) {
//        coreDataEntity.tableName = self.id
    }
}
