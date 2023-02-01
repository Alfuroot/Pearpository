//
//  EditView.swift
//  MySmartRestaurant
//
//  Created by Alessia Andrisani on 18/01/23.
//

import SwiftUI

struct EditView: View {
    
    
    @Environment (\.dismiss) var dismiss
    
    @State var name = ""
    @State var selectedNumber = 2
    @State var reservationDate = Date.now
    @State var smokingArea = false
    @State var animals = false
    @State var isCeliac = false
    @State var isReservedLunch = false
    @State var isReservedDinner = false
    @State var reservation: Reservation
    
    @EnvironmentObject var api: APICaller
    
    //    @State var reservation: Reservation
    
    @Binding var isEditMode: Bool
    
    var body: some View {
        
        GeometryReader { geo in
            VStack(alignment: .leading) {
                Group {
                    Text("Name")
                        .fontWeight(.semibold)
                        .padding()
                    TextField("", text: $name)
                        .padding(.horizontal)
                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.05)
                        .multilineTextAlignment(.leading)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.09)))

                }
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
                
                DatePicker(selection: $reservationDate, in: Date.now...) {
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
                }
                .padding(.horizontal)
                
                Group {
                    Spacer()
                    Button {
                        // Delete reservation
                        dismiss()
                        
                    } label: {
                        BigButton(text: "Delete Reservation", background: .red)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.vertical)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        let res = Reservation(foreignTableName: 0, name: name, numberOfPeople: selectedNumber, date: ISO8601DateFormatter().string(from: reservationDate), smoking: String(smokingArea), animals: String(animals), glutenFree: String(isCeliac), isReservedLunch: String(isReservedLunch), isReservedDinner: String(isReservedDinner))
                        res.id = reservation.id
                        
                        let urlTmp = "\(api.baseURI)/Reservation('\(res.id!)')"
                        
                        Task {
                            
                            print(res.id)
                            try await api.editRecordInFM(urlTmp: urlTmp, data: res)
                            

                        }
                            // More actions to come
                            withAnimation {
                                isEditMode.toggle()
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            withAnimation {
                                isEditMode.toggle()
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
//    struct EditView_Previews: PreviewProvider {
//        static var previews: some View {
//            EditView(isEditMode: .constant(true))
//        }
//    }
