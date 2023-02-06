//
//  FirstViewViewModel.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 03/02/23.
//

import Foundation

extension FirstView {
    @MainActor
    class ViewModel: ObservableObject {
        
        @Published var tmpTableName: String = ""
        @Published var tableList: [Table] = []
        @Published var reservationList: [Reservation] = []
        @Published var tableLunch: [Table] = []
        @Published var tableDinner: [Table] = []
        @Published var lunchIsSelected = true
        @Published var dinnerIsSelected = false
        @Published var date = Date.now
        @Published var isShowingReservation = false
        
        @MainActor
        func loadTableAndRes() async throws {
                tableList.removeAll()
                reservationList.removeAll()
                reservationList = try await APICaller.shared.getFromFM(urlTmp: "\(APICaller.shared.baseURI)/Reservation")
                tableList = try await APICaller.shared.getFromFM(urlTmp: "\(APICaller.shared.baseURI)/Table")
        }
    }
}
