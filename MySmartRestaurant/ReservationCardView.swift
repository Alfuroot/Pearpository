//
//  ReservationCardView.swift
//  CalendarTest
//
//  Created by Alessia Andrisani on 12/01/23.
//

import SwiftUI

struct ReservationCardView: View {
    @State var reservation: Reservation
    
	var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
            VStack(spacing: 2) {
                Text("\(reservation.idTable ?? 0)")
                    .font(.largeTitle).bold()
                
                Text(reservation.name ?? "mammt")
                    .fontWeight(.semibold)
                
                Text(reservation.formattedDate)
                    .foregroundColor(.gray)
                    .font(.title2)
                    .bold()
                    .frame(width: 120)
            }
        }
        .frame(width: 170, height: 130)
	}
}

//struct ReservationCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationCardView(tableName: "")
//    }
//}
