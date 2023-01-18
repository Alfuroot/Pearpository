//
//  MySmartRestaurantApp.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 11/01/23.
//

import SwiftUI
import FMProKit

@main
struct MySmartRestaurantApp: App {
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var FMDataAPIController = FMODataAPI("napoli.fm-testing.com", "MySmartRestaurant", "Admin", "admin", .v4)
    
    var body: some Scene {
        WindowGroup {
            FirstView()
                .environmentObject(FMDataAPIController)
        }
    }
}
