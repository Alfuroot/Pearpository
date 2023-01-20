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
    @State private var isSelected = false
    @State private var isShowingCalendar = false
    @State private var date = Date.now
    @State private var isShowingReservation = false
    let api = APICaller(username: "Admin", password: "admin")
    
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
                        ForEach(FilterType.allCases, id: \.rawValue) { type in
                            FilterButton(isSelected: $isSelected, title: type.rawValue)
                        }
                    }
                    
                    Text("Reserved Tables")
                        .font(.headline)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 11) {
                            ForEach(tableList, id: \.tableName) { table in
                                ReservationCardView(tableName: table.tableName ?? "Missing")
                                    .onTapGesture {
                                        tmpTableName = table.tableName ?? "Missing"
                                        isShowingReservation.toggle()
                                    }
                            }
                        }
                    }
                    .task {
                        do {
                            tableList = try await api.getFromFM(urlTmp: "\(api.baseURI)/Table")
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
        .onAppear {
            
            tableList = PersistenceController.shared.fetchLocalTables()
        }
    }
}

// struct FirstView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstView(tableList: [Table(tableName: "aa")])
//    }
// }
