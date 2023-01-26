//
//  FirstView.swift
//  CalendarTest
//
//  Created by Alessia Andrisani on 12/01/23.
//

import SwiftUI

struct FirstView: View {
    
    @AppStorage("isShowingOnboarding") var isShowingOnboarding = true
    @State private var tmpTableName: String = ""
    @State private var tableList: [Table] = []
    @State private var tableLunch: [Table] = []
    @State private var tableDinner: [Table] = []
    @State private var lunchIsSelected = true
    @State private var dinnerIsSelected = false
    @State private var date = Date.now
    @State private var isShowingReservation = false
    @EnvironmentObject var api: APICaller
    
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
                        Image(systemName: "calendar.badge.clock")
                            .font(.title)
                            .foregroundColor(.primary)
                        DatePicker("Date", selection: $date, displayedComponents: .date).labelsHidden()
                            .padding(.horizontal)
                    }
                    
                    HStack {
                        FilterButton(isSelected: $lunchIsSelected, title: FilterType.lunch.rawValue)
                        FilterButton(isSelected: $dinnerIsSelected, title: FilterType.dinner.rawValue)
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Text("Reserved Tables")
                            .font(.headline)
                        
                        // Number of tables available
                        Text("0/\(tableList.count)")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                    }
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 11) {
                            if lunchIsSelected {
                                ForEach(tableLunch, id: \.id) { table in
                                    NavigationLink { DetailView() } label: {
                                        ReservationCardView(tableName: "Table \(table.id!)")
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            if dinnerIsSelected {
                                ForEach(tableDinner, id: \.id) { table in
                                    NavigationLink { DetailView() } label: {
                                        ReservationCardView(tableName: "Table \(table.id!)")
                                    }
                                }
                            }
                        }
                    }
                    .task {
                        do {
                            tableList = try await api.getFromFM(urlTmp: "\(api.baseURI)/Table")
                            tableLunch = tableList.filter { $0.isReservedLunch == "true" }
                            tableDinner = tableList.filter { $0.isReservedDinner == "true" }
                        } catch {
                            print("\(api.baseURI)/Table")
                        }
                    }
                    .overlay {
                        VStack {
                            Spacer()
                            ButtonAddReservation(isShowingReservation: $isShowingReservation)
                        }
                    }
                }
                .padding()
                .navigationTitle("My Smart Restaurant")
            }
        }
        .sheet(isPresented: $isShowingOnboarding) {
            OnBoardingView(isShowingOnboarding: $isShowingOnboarding)
        }
        .sheet(isPresented: $isShowingReservation) {
            BookingView(tableList: $tableList, api: APICaller(username: "Admin", password: "admin"))
        }
    }
}

// struct FirstView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstView(tableList: [Table(tableName: "aa")])
//    }
// }
