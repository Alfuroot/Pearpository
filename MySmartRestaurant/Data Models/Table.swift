//
//  Table.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 11/01/23.
//

import Foundation

public class Table {
    var tableName: String?
    var isReserved: Reservation?
    
    init(tableName: String) {
        self.tableName = tableName
        self.isReserved = nil
    }
    
    init(tableName: String, isReserved: Reservation) {
        self.tableName = tableName
        self.isReserved = isReserved
    }
    
    init(coreDataEntity: CoreTable) {
        self.tableName = coreDataEntity.tableName
        self.isReserved = coreDataEntity.isReserved as? Reservation
    }
    
    func copyInEntity(coreDataEntity: CoreTable) {
        coreDataEntity.tableName = self.tableName
        coreDataEntity.isReserved = self.isReserved
    }
}
