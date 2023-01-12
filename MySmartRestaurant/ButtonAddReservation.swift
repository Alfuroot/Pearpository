//
//  ButtonAddReservation.swift
//  MySmartRestaurant
//
//  Created by Alessia Andrisani on 11/01/23.
//

import SwiftUI

struct ButtonAddReservation: View {
    var body: some View {
		
		Button {
			//Add reservation
		} label: {
			Text("Add Reservation")
				.font(.title2)
				.frame(minWidth: 370, idealWidth: 370, maxWidth: .infinity, minHeight: 64, idealHeight: 64, maxHeight: 64, alignment: .center)
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
