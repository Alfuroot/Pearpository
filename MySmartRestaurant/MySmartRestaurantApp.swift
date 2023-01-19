//
//  MySmartRestaurantApp.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 11/01/23.
//

import SwiftUI

@main
struct MySmartRestaurantApp: App {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some Scene {
        WindowGroup {
            FirstView()
        }
    }
}
