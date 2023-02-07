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
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Table \(reservation.idTable ?? 0)")
                    .fontWeight(.semibold)
                Spacer()

                Text(reservation.name ?? "No Name")
                    .bold()
                                
                Spacer()
            }
                Text(reservation.formattedDate)
                    .foregroundColor(.gray)
                    .font(.headline)
                    .bold()
        }
//        .padding()
//        .padding(.horizontal, 40)
    }
}

// struct ListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRowView()
//    }
// }
