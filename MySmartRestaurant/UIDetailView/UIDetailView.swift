//
//  ContentView.swift
//  MySmartRestaurant
//
//  Created by Giuseppe Carannante on 11/01/23.
//

import SwiftUI

struct UIDetailView: View {
    @State var name = ""
    @State var numberPeople = 0
    @State var dateTime = Date()


    var body: some View {

        VStack{
            ParamTextField(name: name)
            
            PickerPeople(numberPeople: numberPeople)
            
            PickerDateTime(dateTime: dateTime)
            
            
            AdditionalInformations(isSmockingArea: true, hasAnimal: true, isCeliac: true)
            Spacer()
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UIDetailView()
    }
}
