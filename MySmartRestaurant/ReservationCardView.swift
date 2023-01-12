//
//  ReservationCardView.swift
//  MySmartRestaurant
//
//  Created by Alessia Andrisani on 11/01/23.
//

import SwiftUI

struct ReservationCardView: View {
    var body: some View {
		VStack(spacing: 4) {
			Text("Table 3")
				.font(.largeTitle).bold()
			Text("Scognamiglio")
				.fontWeight(.semibold)
			Text("12:30")
				.foregroundColor(.secondary)
				.font(.title2).bold()
			
		}.padding()
		.background {
			Color(.white)
				.cornerRadius(10)
				
		}
		
		
    }
}

struct ReservationCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationCardView()
    }
}
