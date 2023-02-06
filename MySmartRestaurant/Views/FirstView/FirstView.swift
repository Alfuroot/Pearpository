//
//  FirstView.swift
//  CalendarTest
//
//  Created by Alessia Andrisani on 12/01/23.
//

import SwiftUI

struct FirstView: View {
    
    @StateObject var viewModel = ViewModel()
    @AppStorage("isShowingOnboarding") var isShowingOnboarding = true
    
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: nil), count: 2)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                            .font(.title)
                            .foregroundColor(.primary)
                        DatePicker("Date", selection: $viewModel.date, displayedComponents: .date).labelsHidden()
                            .padding(.horizontal)
                    }
                    
                    HStack {
                        FilterButton(isSelected: $viewModel.lunchIsSelected, title: FilterType.lunch.rawValue)
                        FilterButton(isSelected: $viewModel.dinnerIsSelected, title: FilterType.dinner.rawValue)
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Text("Reserved Tables")
                            .font(.headline)
                        
                        // Number of tables available
                        if viewModel.lunchIsSelected && !viewModel.dinnerIsSelected {
                            Text("\(viewModel.reservationList.filter { $0.isReservedLunch == "true" }.count )/\(viewModel.tableList.count)")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                        } else if viewModel.dinnerIsSelected && !viewModel.lunchIsSelected {
                            Text("\(viewModel.reservationList.filter { $0.isReservedDinner == "true" }.count )/\(viewModel.tableList.count)")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                        } else if viewModel.dinnerIsSelected && viewModel.lunchIsSelected {
                            Text("\(viewModel.reservationList.count)/\(viewModel.tableList.count)")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                        } else if !viewModel.dinnerIsSelected && !viewModel.lunchIsSelected {
                            Text("\(viewModel.reservationList.count)/\(viewModel.tableList.count)")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                        }
                    }
                    VStack {
                            List {
                                if viewModel.lunchIsSelected {
                                    ForEach(viewModel.reservationList.filter { $0.isReservedLunch == "true" }) { reservation in
                                        NavigationLink { DetailView(reservation: reservation) } label: {
                                            ListRowView(reservation: reservation)
                                        }
                                    }
                                } else if viewModel.dinnerIsSelected {
                                    ForEach(viewModel.reservationList.filter { $0.isReservedDinner == "true" }) { reservation in
                                        NavigationLink { DetailView(reservation: reservation) } label: {
                                            ListRowView(reservation: reservation)
                                        }
                                    }
                                } else if viewModel.dinnerIsSelected && viewModel.lunchIsSelected || !viewModel.dinnerIsSelected && !viewModel.lunchIsSelected {
                                    ForEach(viewModel.reservationList) { reservation in
                                        NavigationLink { DetailView(reservation: reservation) } label: {
                                            ListRowView(reservation: reservation)
                                        }
                                    }
                                }
                            }
                            .cornerRadius(10)
                            .listStyle(.plain)
                        
                        .task {
                            do {
                                try await viewModel.loadTableAndRes()
                            } catch {
                                print(error)
                            }
                        }
                        Button {
                            viewModel.isShowingReservation.toggle()
                        } label: {
                            BigButton(text: "Add Reservation")
                        }
                    }
                }
                .padding()
                .navigationTitle("Reservations")
            }
        }
        .sheet(isPresented: $isShowingOnboarding) {
            OnBoardingView(isShowingOnboarding: $isShowingOnboarding)
        }
        .sheet(isPresented: $viewModel.isShowingReservation, onDismiss: {
            Task {
                try await viewModel.loadTableAndRes()
                print("\(viewModel.reservationList.first?.name)")
            }
        }) {
            BookingView(tableList: $viewModel.tableList)
        }
    }
}

// struct FirstView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstView(tableList: [Table(tableName: "aa")])
//    }
// }
