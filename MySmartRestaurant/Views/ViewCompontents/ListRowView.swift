//
//  ListRowView.swift
//  MySmartRestaurant
//
//  Created by Alessia Andrisani on 06/02/23.
//

import SwiftUI

struct ListRowView: View {
    @State var reservation: Reservation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text(reservation.name ?? "No Name")
                .fontWeight(.semibold)
            
            Text("Table \(reservation.idTable ?? 0)")
                .font(.callout)
            
            Text(reservation.formattedDate)
                .foregroundColor(.gray)
                .font(.headline)
                .bold()
        }
    }
}

// struct ListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRowView()
//    }
// }
