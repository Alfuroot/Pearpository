//
//  ButtonAddReservation.swift
//  CalendarTest
//
//  Created by Alessia Andrisani on 12/01/23.
//

import SwiftUI

struct ButtonAddReservation: View {
	var body: some View {
		
		Button {
			//Add reservation
		} label: {
			Text("Add Reservation")
				.font(.title2)
				.frame(width: UIScreen.main.bounds.width / 1.10, height: UIScreen.main.bounds.height / 12)
				.foregroundColor(.white)
				.background(.blue)
				.cornerRadius(12)
		}
		
	}
}

struct ButtonAddReservation_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAddReservation()
    }
}
