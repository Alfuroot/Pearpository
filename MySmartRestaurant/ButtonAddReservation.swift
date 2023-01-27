//
//  ButtonAddReservation.swift
//  CalendarTest
//
//  Created by Alessia Andrisani on 12/01/23.
//

import SwiftUI

struct ButtonAddReservation: View {
    @Binding var isShowingReservation: Bool
	var body: some View {
		Button {
			// Add reservation
            
            isShowingReservation.toggle()
		} label: {
			Text("Add Reservation")
				.font(.title2)
				.frame(width: UIScreen.main.bounds.width / 1.20, height: UIScreen.main.bounds.height / 15)
				.foregroundColor(.white)
				.background(.blue)
				.cornerRadius(12)
		}
	}
}

// struct ButtonAddReservation_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonAddReservation(false)
//    }
// }
