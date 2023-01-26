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
    @State var petArea = false
    @State var isCeliac = false
    
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
                    
                    Button {
                        // Delete reservation
                        dismiss()
                
                    } label: {
                        Text("Delete Reservation")
                            .font(.title2)
                            .frame(width: UIScreen.main.bounds.width / 1.20, height: UIScreen.main.bounds.height / 15)
                            .foregroundColor(.white)
                            .background(.red)
                            .cornerRadius(12)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.vertical)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
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
                .padding()
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
            }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(isEditMode: .constant(true))
    }
}
