//
//  BookingView.swift
//  MySmartRestaurant
//
//  Created by Antonio Scognamiglio on 11/01/23.
//

import SwiftUI

struct BookingView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @Binding var tableList: [Table]
    @State var name = ""
    @State var selectedNumber = 2
    @State var date = Date.now
    @State var smokingArea = false
    @State var petArea = false
    @State var isCeliac = false
    @State var selectedTable = 0
    var api: APICaller
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    Text("Name")
                        .fontWeight(.semibold)
                        .padding()
                    TextField("", text: $name)
                        .padding(.horizontal)
                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.05)
                        .multilineTextAlignment(.leading)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.09)))
                    Divider()
                    Text("Number of People")
                        .fontWeight(.semibold)
                        .padding()
                    Picker("Number of people", selection: $selectedNumber) {
                        ForEach(1...20, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: geo.size.height * 0.16)
                    Divider()
                    
                    DatePicker(selection: $date, in: Date.now...) {
                        Text("Date to reserve")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    Divider()
                    Text("Preferences")
                        .fontWeight(.semibold)
                        .padding()
                    VStack {
                        Toggle(isOn: $smokingArea) {
                            Text("Smoking Area")
                        }
                        Toggle(isOn: $petArea) {
                            Text("Animals")
                        }
                        Toggle(isOn: $isCeliac) {
                            Text("Gluten Free")
                        }
                        ForEach(tableList, id: \.id) { table in
                            if table.isReservedLunch != "true" && table.isReservedDinner != "true" {
                                Button(action: {
                                    selectedTable = Int(table.id ?? 0)
                                }, label: {
                                    Text("Table "+"\(table.id!)")
                                        .foregroundColor(selectedTable == Int(table.id ?? 0) ? .blue : .black)
                                })
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {

                            Task {
                                if selectedTable != 0 {
                                    try await api.createRecordInFM(urlTmp: "\(api.baseURI)/Reservation", data: Reservation(foreignTableName: selectedTable, name: name, numberOfPeople: selectedNumber, date: ISO8601DateFormatter().string(from: date), smoking: String(smokingArea), animals: String(petArea), glutenFree: String(isCeliac)))
                                    let tmpTable = Table(isReservedLunch: "true", isReservedDinner: "false")
                                    try await api.editRecordInFM(urlTmp: "\(api.baseURI)/Table(\(selectedTable))", data: tmpTable)
                                } else {
                                    
                                }
                            }
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
                .padding()
            }
        }
    }
}

//struct BookingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingView()
//    }
//}
