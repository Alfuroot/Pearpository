//
//  ButtonAddReservation.swift
//  CalendarTest
//
//  Created by Alessia Andrisani on 12/01/23.
//

import SwiftUI

struct BigButton: View {
    var text: String
    var background: Color = .blue

	var body: some View {
			Text(text)
				.font(.title2)
				.frame(width: UIScreen.main.bounds.width / 1.20, height: UIScreen.main.bounds.height / 15)
				.foregroundColor(.white)
				.background(background)
				.cornerRadius(12)	
	}
}

// struct ButtonAddReservation_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonAddReservation(false)
//    }
// }
