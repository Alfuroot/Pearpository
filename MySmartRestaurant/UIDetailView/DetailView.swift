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
    
    var noSmokingArea = true
    var hasAnimals = true
    var glutenFree = true
    
    
    var body: some View {
        NavigationStack {
            if !isEditMode {
                VStack {
                    Form {
                        
                        Section {
                            Text("Andrisani")
                        } header: {
                            Text("Name")
                        }
                        
                        Section {
                            Text("4")
                        }  header: {
                            Text("Number of People")
                        }
                        Section {
                            Text(date.formatted(date: .numeric, time: .omitted))
                        }  header: {
                            Text("Date")
                        }
                        
                        Section {
                            Text("21.00")
                        }  header: {
                            Text("Reservation Time")
                        }
                        VStack {
                            if noSmokingArea {
                                HStack {
                                    Image("smoking")
                                    Spacer()
                                    Text("No Smoking Area")
                                }
                                Divider()
                            }
                            
                            if hasAnimals {
                                HStack {
                                    Image(systemName: "pawprint.fill")
                                    Spacer()
                                    Text("Animals")
                                }
                                
                                Divider()
                            }
                            
                            
                            if glutenFree {
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
                .toolbar {
                    ToolbarItem {
                        Button("Edit") {
                            withAnimation {
                                isEditMode.toggle()
                            }
                        }
                    }
                }
            } else {
                EditView(isEditMode: $isEditMode)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}