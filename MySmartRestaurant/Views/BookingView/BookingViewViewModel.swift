//
//  BookingViewViewModel.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 03/02/23.
//

import Foundation

extension BookingView {
    
    class ViewModel: ObservableObject {
        @Published var name = ""
        @Published var selectedNumber = 2
        @Published var date = Date.now
        @Published var smokingArea = false
        @Published var petArea = false
        @Published var isCeliac = false
        @Published var isReservedLunch = false
        @Published var isReservedDinner = false
        @Published var selectedTable = 0
        @Published var reservationList: [Reservation] = []
        @Published private var tmpTables: [Table] = []
        
        @MainActor
        func loadTables() async throws -> [Table] {
            tmpTables = []
            tmpTables = try await APICaller.shared.getFromFM(urlTmp: "\(APICaller.shared.baseURI)/Table")
            reservationList = try await APICaller.shared.getFromFM(urlTmp: "\(APICaller.shared.baseURI)/Reservation")
            for res in reservationList {
                if res.isReservedLunch == "true" && res.isReservedDinner == "true" {
                    tmpTables.removeAll(where: { $0.id == res.idTable })
                }
            }
            selectedTable = tmpTables.first!.id ?? 0
            return tmpTables
        }
        
        func addReservation() async throws {
            
            if selectedTable != 0 {
                let hours = Calendar.current.component(.hour, from: date)
                
                if hours < 16 {
                    isReservedLunch = true
                } else {
                    isReservedDinner = true
                }
                
                let reservation = Reservation(foreignTableName: selectedTable, name: name, numberOfPeople: selectedNumber, date: ISO8601DateFormatter().string(from: date), smoking: String(smokingArea), animals: String(petArea), glutenFree: String(isCeliac), isReservedLunch: String(isReservedLunch), isReservedDinner: String(isReservedDinner))
                
                print(reservation)
                
                try await APICaller.shared.createRecordInFM(urlTmp: "\(APICaller.shared.baseURI)/Reservation", data: reservation)
                PersistenceController.shared.saveNewReservation(reservation)
            }
        }
    }
}
