//
//  NameTextField.swift
//  MySmartRestaurant
//
//  Created by Francesco De Marco on 12/01/23.
//

import SwiftUI

struct AdditionalInformations: View {
    
    var isSmockingArea, hasAnimal, isCeliac: Bool

    var body: some View {

        VStack {
            
            if isSmockingArea {
                HStack {
                    Image("smoking")
                    Text("No Smoking Area")
                    
                    Spacer()
                }
            }
            
            if hasAnimal {
                HStack {
                    Image(systemName: "pawprint.fill")
                    Text("Animals")
                    
                    Spacer()
                }
            }
            
            if isCeliac {
                HStack {
                    Image("celiac")
                    Text("Gluten Free")
                    
                    Spacer()
                }
            }
        }
    }
}

struct  AdditionalInformations_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalInformations(isSmockingArea: true, hasAnimal: true, isCeliac: true)
    }
}


