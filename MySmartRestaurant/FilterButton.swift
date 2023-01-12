	//
	//  FilterButton.swift
	//  MySmartRestaurant
	//
	//  Created by Alessia Andrisani on 11/01/23.
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
								.strokeBorder(.black, lineWidth: 3)
								.background(RoundedRectangle(cornerRadius: 8).fill(isSelected ? .black.opacity(0.7) : .white))
								.frame(width: .infinity)
								  
						)

			}

		}
	}

	struct FilterButton_Previews: PreviewProvider {
		static var previews: some View {
			FilterButton(isSelected: .constant(true), title: "Lunch")
		}
	}
