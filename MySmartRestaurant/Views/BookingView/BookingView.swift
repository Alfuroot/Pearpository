//
//  BookingView.swift
//  MySmartRestaurant
//
//  Created by Antonio Scognamiglio on 11/01/23.
//

import SwiftUI

struct BookingView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @StateObject var viewModel = ViewModel()
    @Binding var tableList: [Table]
    @EnvironmentObject var api: APICaller
    
    let columns = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
    ]
    var body: some View {
        
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .fontWeight(.semibold)
                            .padding()
                        TextField("", text: $viewModel.name)
                            .padding(.horizontal)
                            .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.05)
                            .multilineTextAlignment(.leading)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.09)))
                        Divider()
                        Text("Number of People")
                            .fontWeight(.semibold)
                            .padding()
                        Picker("Number of people", selection: $viewModel.selectedNumber) {
                            ForEach(1...20, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: geo.size.height * 0.16)
                        Divider()
                        
                        DatePicker(selection: $viewModel.date, in: Date.now...) {
                            Text("Date to reserve")
                                .fontWeight(.semibold)
                        }
                        .padding()
                        Divider()
                        Text("Preferences")
                            .fontWeight(.semibold)
                            .padding()
                        VStack(alignment: .leading) {
                            Group {
                                Toggle(isOn: $viewModel.smokingArea) {
                                    Text("Smoking Area")
                                }
                                Toggle(isOn: $viewModel.petArea) {
                                    Text("Animals")
                                }
                                Toggle(isOn: $viewModel.isCeliac) {
                                    Text("Gluten Free")
                                }
                            }.padding(.horizontal)
                            
                            Divider()
                            
                            Text("Select a table")
                                .fontWeight(.semibold)
                                .padding()
                            //                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            LazyVGrid(columns: columns) {
                                ForEach(tableList, id: \.id) { table in
                                    if table.isReservedLunch != "true" && table.isReservedDinner != "true" {
                                        Button(action: {
                                            viewModel.selectedTable = Int(table.id ?? 0)
                                        }, label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .foregroundColor(viewModel.selectedTable == Int(table.id ?? 0) ? .blue : Color.gray.opacity(0.7))
                                                
                                                Text("\(table.id!)")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.white)
                                            }
                                        })
                                    }
                                }
                            }.onAppear {
                                Task {
                                    tableList = try await viewModel.loadTables()
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            
                            Task {
                                do {
                                   try await viewModel.addReservation()
                                } catch {
                                    print(error)
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
            }
        }
    }
}

//  struct BookingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingView()
//    }
//  }
