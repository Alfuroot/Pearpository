//
//  NameTextField.swift
//  MySmartRestaurant
//
//  Created by Francesco De Marco on 12/01/23.
//

import SwiftUI

struct ParamTextField: View {
    @State var name : String

    var body: some View {

        VStack{
            HStack{
                Text("Name")
                    .font(.system(size: 12, weight: .bold))
                    .padding()
                Spacer()
            }
            
            
            
            TextField("Name", text: $name)
                .background {
                    RoundedRectangle(cornerRadius: 10).fill(Color(.gray).opacity(0.5))
                        .frame(height: 45)
                }.frame(width: 370, alignment: .trailing)
                
                
        }
    }
}

struct  ParamTextField_Previews: PreviewProvider {
    static var previews: some View {
        ParamTextField(name: "Andrisani")
    }
}
