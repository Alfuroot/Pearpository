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
		VStack(spacing: 4) {
            Text("\(reservation.idTable ?? 0)")
				.font(.largeTitle).bold()
            
            Text(reservation.name ?? "mammt")
				.fontWeight(.semibold)
            
            Text(reservation.date ?? "MAI")
				.foregroundColor(.gray)
				.font(.title2)
                .bold()
		}.padding()
		.background {
			Color(.white)
				.cornerRadius(10)
		}
	}
}

//struct ReservationCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationCardView(tableName: "")
//    }
//}
