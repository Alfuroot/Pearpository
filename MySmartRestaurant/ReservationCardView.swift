//
//  ReservationCardView.swift
//  CalendarTest
//
//  Created by Alessia Andrisani on 12/01/23.
//

import SwiftUI

struct ReservationCardView: View {
    @State var reservation: Reservation
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        /// we can avoid the calendar components, but the layout it's different, I don't know why ...
        if let date = dateFormatter.date(from: reservation.date!) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
            if let finalDate = calendar.date(from: components) {
                return finalDate.formatted(.dateTime.locale(.current))
            } else {
                print("Failed to create finalDate")
                return "Failed to create finalDate"
            }
        } else {
            print("Failed to convert string to Date")
            return "Failed to convert string to Date"
        }
        
        /// This one is better, because simpler, but I don't know why the layout is different
//        if let date = dateFormatter.date(from: reservation.date!)?.formatted(.dateTime.locale(.current)){
//            return date
//        } else {
//            return "Failed to convert Date"
//        }
    }
    
	var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
            VStack {
                Text("\(reservation.idTable ?? 0)")
                    .font(.largeTitle).bold()
                
                Text(reservation.name ?? "mammt")
                    .fontWeight(.semibold)
                
                Text(formattedDate)
                    .foregroundColor(.gray)
                    .font(.title2)
                    .bold()
            }
        }
        .frame(width: 160, height: 120)
	}
}

//struct ReservationCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationCardView(tableName: "")
//    }
//}
