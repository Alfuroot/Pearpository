//
//  MySmartRestaurantApp.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 11/01/23.
//

import SwiftUI

@main
struct MySmartRestaurantApp: App {
    
    @StateObject var api = APICaller(username: "Admin", password: "admin")
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some Scene {
        WindowGroup {
            if !UserDefaults.standard.bool(forKey: "firstTime") {
                OnBoardingView()
                    .environmentObject(api)
            } else {
                FirstView()
                    .environmentObject(api)
            }
        }
    }
}
