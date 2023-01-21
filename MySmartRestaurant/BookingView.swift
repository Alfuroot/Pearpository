//
//  BookingView.swift
//  MySmartRestaurant
//
//  Created by Antonio Scognamiglio on 11/01/23.
//

import SwiftUI

struct BookingView: View {
    @Environment (\.dismiss) var dismiss
    
    @Binding var tableName: String
    @State var name = ""
    @State var selectedNumber = 2
    @State var date = Date.now
    @State var smokingArea = false
    @State var petArea = false
    @State var isCeliac = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    Text("Name")
                        .fontWeight(.semibold)
                        .padding()
                    TextField("", text: $name)
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
                    }
                    .padding(.horizontal)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            // More actions to come
                            let tmpRes = Reservation(foreignTableName: tableName, name: name, numberOfPeople: selectedNumber, date: date, smoking: smokingArea, animals: petArea, glutenFree: isCeliac)

                            
//                            PersistenceController.shared.saveNewReservation(tmpRes, tableName)
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
