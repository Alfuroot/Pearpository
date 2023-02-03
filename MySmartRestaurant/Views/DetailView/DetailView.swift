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
                            Text(reservation.name ?? "mammt")
                        } header: {
                            Text("Name")
                        }
                        
                        Section {
                            Text("\(reservation.seats ?? 0)")
                        }  header: {
                            Text("Number of seats")
                        }
                        Section {
                            Text(date.formatted(date: .numeric, time: .omitted))
                        }  header: {
                            Text("Date")
                        }
                        
                        Section {
                            Text(reservation.date ?? "No date")
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
                                    Divider()
                                }
                                
                                if reservation.hasAnimals?.boolValue ?? false {
                                    HStack {
                                        Image(systemName: "pawprint.fill")
                                        Spacer()
                                        Text("Animals")
                                    }
                                    
                                    Divider()
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
                        } else {
                            /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
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
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
