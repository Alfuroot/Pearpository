//
//  EditViewViewModel.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 03/02/23.
//

import Foundation

extension EditView {
    class ViewModel: ObservableObject {
        
        @Published var name = ""
        @Published var selectedNumber = 2
        @Published var reservationDate = Date.now
        @Published var smokingArea = false
        @Published var animals = false
        @Published var isCeliac = false
        @Published var isReservedLunch = false
        @Published var isReservedDinner = false
        
        func editView(reservation: Reservation) {
            let res = Reservation(foreignTableName: 0, name: name, numberOfPeople: selectedNumber, date: ISO8601DateFormatter().string(from: reservationDate), smoking: String(smokingArea), animals: String(animals), glutenFree: String(isCeliac), isReservedLunch: String(isReservedLunch), isReservedDinner: String(isReservedDinner))
            res.id = reservation.id
            
            let urlTmp = "\(APICaller.shared.baseURI)/Reservation('\(res.id!)')"
            
            Task {
                print(res.id)
                try await APICaller.shared.editRecordInFM(urlTmp: urlTmp, data: res)
            }
        }
        
        func loadValues(reservation: Reservation){
            name = reservation.name ?? ""
            selectedNumber = reservation.seats ?? 0
            reservationDate = ISO8601DateFormatter().date(from: reservation.date ?? "") ?? Date()
            smokingArea = reservation.inSmokingArea?.boolValue ?? false
            animals = reservation.hasAnimals?.boolValue ?? false
            isCeliac = reservation.isCeliac?.boolValue ?? false
        }
    }
}
