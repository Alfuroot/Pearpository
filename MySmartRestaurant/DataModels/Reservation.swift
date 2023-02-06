//
//  Reservation.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 11/01/23.
//

import Foundation

public class Reservation: NSObject, Codable, Identifiable {
    public var id: String?
    var idTable: Int?
    var name: String?
    var seats: Int?
    var date: String?
    var inSmokingArea: String?
    var hasAnimals: String?
    var isCeliac: String?
    var isReservedLunch: String?
    var isReservedDinner: String?

    // Date Formatter
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let convertedDate = dateFormatter.date(from: date!)?.formatted(.dateTime.locale(.current)){
            return convertedDate
        } else {
            return "Failed to convert Date"
        }
    }
    
    // Date Formatter
    var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let convertedDate = dateFormatter.date(from: date!)?.formatted(date: .omitted, time: .shortened) {
            return convertedDate
        } else {
            return "Failed to convert Time"
        }
    }
    
    // To Create an Object
    init(foreignTableName: Int, name: String, numberOfPeople: Int, date: String, smoking: String, animals: String, glutenFree: String, isReservedLunch: String, isReservedDinner: String) {
        self.idTable = foreignTableName
        self.name = name
        self.seats = numberOfPeople
        self.date = date
        self.inSmokingArea = smoking
        self.hasAnimals = animals
        self.isCeliac = glutenFree
        self.isReservedLunch = isReservedLunch
        self.isReservedDinner = isReservedLunch
    }
    
    // To retrieve data from coredata
    init(coreDataEntity: CoreReservation) {
        self.idTable = Int(coreDataEntity.idTable)
        self.name = coreDataEntity.name
        self.seats = Int(coreDataEntity.numberOfPeople)
        self.date = coreDataEntity.date
        self.inSmokingArea = String(coreDataEntity.smoking)
        self.hasAnimals = String(coreDataEntity.animals)
        self.isCeliac = String(coreDataEntity.glutenFree)
    }
    
    // Save in CoreData
    func copyInEntity(coreDataEntity: CoreReservation) {
        coreDataEntity.idTable = Int16(self.idTable ?? 0)
        coreDataEntity.name = self.name
        coreDataEntity.numberOfPeople = Int16(self.seats!)
        coreDataEntity.date = self.date!
        coreDataEntity.smoking = self.inSmokingArea!.boolValue
        coreDataEntity.animals = self.hasAnimals!.boolValue
        coreDataEntity.glutenFree = self.isCeliac!.boolValue
    }
}

public class SupportReservation: Codable {
        var idTable: Int?
        var name: String?
        var seats: Int?
        var date: Date?
        var inSmokingArea: String?
        var hasAnimals: String?
        var isCeliac: String?
    
    init(foreignTableName: Int, name: String, numberOfPeople: Int, date: Date, smoking: String, animals: String, glutenFree: String) {
        self.idTable = foreignTableName
        self.name = name
        self.seats = numberOfPeople
        self.date = date
        self.inSmokingArea = smoking
        self.hasAnimals = animals
        self.isCeliac = glutenFree
    }
}
