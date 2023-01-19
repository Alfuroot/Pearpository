//
//  Table.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 11/01/23.
//

import Foundation

public class Table: Codable {
    var tableName: String?
    
    init(tableName: String) {
        self.tableName = tableName
    }
    
    init(coreDataEntity: CoreTable) {
        self.tableName = coreDataEntity.tableName
    }
    
    func copyInEntity(coreDataEntity: CoreTable) {
        coreDataEntity.tableName = self.tableName
    }
}
