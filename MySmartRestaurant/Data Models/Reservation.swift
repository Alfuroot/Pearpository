//
//  Reservation.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 11/01/23.
//

import Foundation

public class Reservation: NSObject {
    
    var name: String?
    var numberOfPeople: Int?
    var date: Date?
    var smoking: Bool?
    var animals: Bool?
    var glutenFree: Bool?
    
    init(name: String, numberOfPeople: Int, date: Date, smoking: Bool, animals: Bool, glutenFree: Bool) {
        self.name = name
        self.numberOfPeople = numberOfPeople
        self.date = date
        self.smoking = smoking
        self.animals = animals
        self.glutenFree = glutenFree
    }
    
    init(coreDataEntity: CoreReservation) {
        self.name = coreDataEntity.name
        self.numberOfPeople = Int(coreDataEntity.numberOfPeople)
        self.date = coreDataEntity.date
        self.smoking = coreDataEntity.smoking
        self.animals = coreDataEntity.animals
        self.glutenFree = coreDataEntity.glutenFree
    }
    
    func copyInEntity(coreDataEntity: CoreReservation) {
        coreDataEntity.name = self.name
        coreDataEntity.numberOfPeople = Int16(self.numberOfPeople!)
        coreDataEntity.date = self.date!
        coreDataEntity.smoking = self.smoking!
        coreDataEntity.animals = self.animals!
        coreDataEntity.glutenFree = self.glutenFree!
    }
}
