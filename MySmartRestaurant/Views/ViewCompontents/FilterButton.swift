//
//  FilterButton.swift
//  CalendarTest
//
//  Created by Alessia Andrisani on 12/01/23.
//

import SwiftUI

struct FilterButton: View {
	@Binding var isSelected: Bool
	var title: String
	
	var body: some View {
		Button {
			isSelected.toggle()
		} label: {
			Text(title)
				.padding()
				.foregroundColor(isSelected ? .white : .black)
				.background(
						RoundedRectangle(cornerRadius: 8)
                            .fill(isSelected ? Color.accentColor : .white)
//							.strokeBorder(.black, lineWidth: 1)
//							.background(RoundedRectangle(cornerRadius: 8).fill(isSelected ? .blue : .white))
					)
		}
	}
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
		FilterButton(isSelected: .constant(true), title: "Lunch")
    }
}
