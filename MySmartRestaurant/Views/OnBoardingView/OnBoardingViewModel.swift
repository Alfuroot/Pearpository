//
//  OnBoardingViewModel.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 03/02/23.
//

import Foundation

extension OnBoardingView {
    
    class ViewModel: ObservableObject {
        @Published var numberOfTables: Int = 8
        @Published var numberOfOutDoorTables: Int = 0
        
        func pushTablesInDB() async throws {
            try await APICaller.shared.deleteRecordInFM(urlTmp: "\(APICaller.shared.baseURI)/Table?$filter=id ne null".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            if numberOfOutDoorTables > 0 {
                for i in 1...numberOfOutDoorTables {
                    try await APICaller.shared.createRecordInFM(urlTmp: "\(APICaller.shared.baseURI)/Table", data: Table(tableName: i, isOutdoor: "true"))
                }
            }
            for i in numberOfOutDoorTables + 1...numberOfTables + numberOfOutDoorTables {
                try await APICaller.shared.createRecordInFM(urlTmp: "\(APICaller.shared.baseURI)/Table", data: Table(tableName: i, isOutdoor: "false"))
            }
        }
    }
}
