//
//  NameTextField.swift
//  MySmartRestaurant
//
//  Created by Francesco De Marco on 12/01/23.
//

import SwiftUI

struct PickerDateTime: View {
    @State var dateTime : Date

    var body: some View {

        VStack{
            HStack{
                Text("Reservation Time")
                    .font(.system(size: 12, weight: .bold))
                    .padding()
                Spacer()
            }
            
            HStack{
                DatePicker("", selection: $dateTime)
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
