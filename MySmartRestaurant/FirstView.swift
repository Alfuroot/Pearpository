//
//  FirstView.swift
//  CalendarTest
//
//  Created by Alessia Andrisani on 12/01/23.
//

import SwiftUI

struct FirstView: View {
    
    @State private var tmpTableName: String = ""
    @State private var tableList: [Table] = []
    @State private var tableLunch: [Table] = []
    @State private var tableDinner: [Table] = []
    @State private var lunchIsSelected = false
    @State private var dinnerIsSelected = false
    @State private var isShowingCalendar = false
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
                        Button {
                            // show calendar
                            isShowingCalendar.toggle()
                        } label: {
                            Image(systemName: "calendar.badge.clock")
                                .font(.title)
                                .foregroundColor(.primary)
                        }
                        Text("\(date.formatted(date: .abbreviated, time: .omitted))")
                            .bold()
                        
                        // Number of tables available
                        Text("2/10")
                            .font(.title)
                            .bold()
                            .padding(.horizontal)
                    }
                    
                    HStack {
                        FilterButton(isSelected: $lunchIsSelected, title: FilterType.lunch.rawValue)
                        FilterButton(isSelected: $dinnerIsSelected, title: FilterType.dinner.rawValue)
                    }
                    
                    Text("Reserved Tables")
                        .font(.headline)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 11) {
                            if lunchIsSelected {
                                ForEach(tableLunch, id: \.id) { table in
                                    NavigationLink { DetailView() } label: {
                                        ReservationCardView(tableName: "Table\(table.id!)")
                                    }
                                }
                            }
                            if dinnerIsSelected {
                                ForEach(tableDinner, id: \.id) { table in
                                    NavigationLink { DetailView() } label: {
                                        ReservationCardView(tableName: "Table\(table.id!)")
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
                
                if isShowingCalendar {
                    Color.black
                        .opacity(0.6)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShowingCalendar.toggle()
                        }
                    DatePicker("Date", selection: $date, in: Date.now..., displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .background(.white)
                        .cornerRadius(10)
                }
            }
        }
        .sheet(isPresented: $isShowingReservation) {
            BookingView(tableName: $tmpTableName)
        }
    }
}

// struct FirstView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstView(tableList: [Table(tableName: "aa")])
//    }
// }
