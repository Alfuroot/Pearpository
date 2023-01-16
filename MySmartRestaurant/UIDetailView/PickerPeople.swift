//
//  NameTextField.swift
//  MySmartRestaurant
//
//  Created by Francesco De Marco on 12/01/23.
//

import SwiftUI

struct PickerPeople: View {
    @State var numberPeople : Int

    var body: some View {

        VStack{
            HStack{
                Text("Number of people")
                    .font(.system(size: 12, weight: .bold))
                    .padding()
                Spacer()
            }
            
            HStack{
                Picker("numberPeople", selection: $numberPeople){
                    ForEach((1...10), id: \.self) {
                        Text("\($0)").tag($0)
                        }
                }
                .background{
                    RoundedRectangle(cornerRadius: 10).fill(Color(.gray).opacity(0.5))
                        .frame(height: 45)
                }
                .padding()
                
                Spacer()
            }
                
        }
    }
}
