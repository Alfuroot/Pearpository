//
//  DetailView.swift
//  MySmartRestaurant
//
//  Created by Alessia Andrisani on 18/01/23.
//

import SwiftUI

struct DetailView: View {
    
    @State private var date: Date = .now
    
    @State private var isEditMode = false
    
    @State var reservation: Reservation
    
    
    var body: some View {
       
            if !isEditMode {
                VStack {
                    Form {
                        Section {
                            Text(reservation.name ?? "No name")
                        } header: {
                            Text("Name")
                        }
                        
                        Section {
                            Text("\(reservation.seats ?? 0)")
                        }  header: {
                            Text("Number of seats")
                        }
                        Section {
                            Text(formattedDate)
                        }  header: {
                            Text("Date")
                        }
                        
                        Section {
                            Text(reservation.formattedTime ?? "No time")
                        }  header: {
                            Text("Reservation Time")
                        }
                        
                        if (reservation.inSmokingArea?.boolValue ?? false) || (reservation.hasAnimals?.boolValue ?? false) || (reservation.isCeliac?.boolValue ?? false) {
                            VStack {
                                if reservation.inSmokingArea?.boolValue ?? false {
                                    HStack {
                                        Image("smoking")
                                        Spacer()
                                        Text("Smoking Area")
                                    }
                                    if reservation.hasAnimals?.boolValue ?? false || reservation.isCeliac?.boolValue ?? false {
                                        Divider()
                                    }
                                }
                                
                                if reservation.hasAnimals?.boolValue ?? false {
                                    HStack {
                                        Image(systemName: "pawprint.fill")
                                        Spacer()
                                        Text("Animals")
                                    }
                                    if reservation.isCeliac?.boolValue ?? false {
                                        Divider()
                                    }
                                }
                                
                                
                                if reservation.isCeliac?.boolValue ?? false {
                                    HStack {
                                        ZStack {
                                            Image(systemName: "laurel.leading")
                                                .font(.title)
                                                .bold()
                                            Image(systemName: "xmark")
                                                .foregroundColor(.red)
                                                .font(.title)
                                        }
                                        Spacer()
                                        Text("Gluten Free")
                                    }
                                }
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem {
                        Button("Edit") {
                            withAnimation {
                                isEditMode.toggle()
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            } else {
                EditView(reservation: $reservation, isEditMode: $isEditMode)
            }
    }
    
    // Date Formatter
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let convertedDate = dateFormatter.date(from: reservation.date!)?.formatted(date: .abbreviated, time: .omitted) {
            return convertedDate
        } else {
            return "Failed to convert Date"
        }
    }
}

// struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
// }
