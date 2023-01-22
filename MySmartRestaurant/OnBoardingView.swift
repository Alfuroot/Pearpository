//
//  OnBoardingView.swift
//  MySmartRestaurant
//
//  Created by Antonio Scognamiglio on 18/01/23.
//

import SwiftUI

struct OnBoardingView: View {
    
    @State var numberOfTables: Int = 8
    @State var numberOfOutoDoorTables: Int = 0
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Wecolme to my Smart Restaurant")
                    .font(.largeTitle)
                HStack {
                    Text("How many tables are there indoor?")
                        .fontWeight(.medium)
                    Spacer()
                }
                .padding()
                Picker("Indoor tables", selection: $numberOfTables) {
                    ForEach(4...100, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: geo.size.height * 0.16)
                HStack {
                    Text("How many tables are there outdoor?")
                        .fontWeight(.medium)
                    Spacer()
                }
                .padding()
                Picker("Outdoor tables", selection: $numberOfOutoDoorTables) {
                    ForEach(4...100, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: geo.size.height * 0.16)
                Spacer()
                Button {
                   
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.blue)
                            .frame(width: geo.size.width * 0.88, height: geo.size.height * 0.08)
                        Text("Confirm")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding()
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
