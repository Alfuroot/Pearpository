		//
		//  ContentView.swift
		//  MySmartRestaurant
		//
		//  Created by Giuseppe Carannante on 11/01/23.
		//

		import SwiftUI

		struct ContentView: View {
			@State private var isSelected = false
			
			@State private var isShowingCalendar = false
			
			@State private var date = Date.now
			
			let columns = [
				GridItem(.flexible()),
				GridItem(.flexible())
			  ]
			
			var body: some View {
				NavigationStack {
					ZStack {
						Color(uiColor: .systemGroupedBackground)
							.ignoresSafeArea()
					VStack(alignment: .leading) {
						HStack {
							Button {
								//show calendar
								isShowingCalendar.toggle()
							} label: {
								Image(systemName: "calendar.badge.clock")
									.font(.title)
									.foregroundColor(.primary)
							}
							Text("Today - 11 January 2023")
								.bold()
							Text("2/10")
								.font(.title).bold()
								.padding(.horizontal)
						}
						
						HStack {
							ForEach(FilterType.allCases, id: \.rawValue) { type in
								FilterButton(isSelected: $isSelected, title: type.rawValue)
								
							}
							
						}
						
						Text("Reserved Tables")
							.font(.headline)
							
						
						ScrollView {
							LazyVGrid(columns: columns, spacing: 11) {
								ForEach(0..<10) { _ in
									ReservationCardView()
										
									
								}
							}
						}
						.overlay {
							VStack {
								Spacer()
								ButtonAddReservation()
								
							}
						}
						
					}
					.padding()
					.navigationTitle("My Smart Restaurant")
						
						if isShowingCalendar {
							Color.black.opacity(0.6).ignoresSafeArea()
								.onTapGesture {
									isShowingCalendar.toggle()
								}
							DatePicker("Date", selection: $date)
								.datePickerStyle(.graphical)
								.background(.white)
								.cornerRadius(10)
								
						}
						
				}
					
				}
			}
		}

		struct ContentView_Previews: PreviewProvider {
			static var previews: some View {
				ContentView()
			}
		}
