//
//  EditView.swift
//  MySmartRestaurant
//
//  Created by Alessia Andrisani on 18/01/23.
//

import SwiftUI

struct EditView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @StateObject var viewModel = ViewModel()
    @Binding var reservation: Reservation
    
    @EnvironmentObject var api: APICaller
    
    @Binding var isEditMode: Bool
    
    var body: some View {
        
        GeometryReader { geo in
            VStack(alignment: .leading) {
                Group {
                    Text("Name")
                        .fontWeight(.semibold)
                        .padding()
                    TextField("", text: $viewModel.name)
                        .padding(.horizontal)
                        .frame(width: geo.size.width * 0.98, height: geo.size.height * 0.05)
                        .multilineTextAlignment(.leading)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.09)))
                }
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
                
                DatePicker(selection: $viewModel.reservationDate, in: Date.now...) {
                    Text("Date to reserve")
                        .fontWeight(.semibold)
                }
                .padding()
                Divider()
                Text("Preferences")
                    .fontWeight(.semibold)
                    .padding()
                VStack {
                    Toggle(isOn: $viewModel.smokingArea) {
                        Text("Smoking Area")
                    }
                    Toggle(isOn: $viewModel.animals) {
                        Text("Animals")
                    }
                    Toggle(isOn: $viewModel.isCeliac) {
                        Text("Gluten Free")
                    }
                }
                .padding(.horizontal)
                
                Group {
                    Spacer()
                    Button {
                        // Delete reservation
                        Task {
                            try await api.deleteRecordInFM(urlTmp: "\(api.baseURI)/Reservation('\(reservation.id!)')")
                        }
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
                        viewModel.editView(reservation: reservation)
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
        .onAppear {
            Task {
                viewModel.loadValues(reservation: reservation)
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
