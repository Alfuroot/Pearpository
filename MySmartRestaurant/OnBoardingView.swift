//
//  OnBoardingView.swift
//  MySmartRestaurant
//
//  Created by Antonio Scognamiglio on 18/01/23.
//

import SwiftUI

struct OnBoardingView: View {
    
    @Binding var isShowingOnboarding: Bool
    @State var numberOfTables: Int = 8
    @State var numberOfOutDoorTables: Int = 0
    @EnvironmentObject var api: APICaller
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Welcome to my Smart Restaurant")
                    .font(.largeTitle)
                HStack {
                    Text("How many indoor tables?")
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
                    Text("How many outdoor tables?")
                        .fontWeight(.medium)
                    Spacer()
                }
                .padding()
                Picker("Outdoor tables", selection: $numberOfOutDoorTables) {
                    ForEach(0...100, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: geo.size.height * 0.16)
                Spacer()
              
                    Button {
                        isShowingOnboarding = false
                        Task {
                            try await api.deleteRecordInFM(urlTmp: "\(api.baseURI)/Table?$filter=id ne null".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
                            if numberOfOutDoorTables > 0 {
                                for i in 1...numberOfOutDoorTables {
                                    try await api.createRecordInFM(urlTmp: "\(api.baseURI)/Table", data: Table(tableName: i, isOutdoor: "true"))
                                }
                            }
                            for i in numberOfOutDoorTables + 1...numberOfTables + numberOfOutDoorTables {
                                try await api.createRecordInFM(urlTmp: "\(api.baseURI)/Table", data: Table(tableName: i, isOutdoor: "false"))
                            }
                        }
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
        OnBoardingView(isShowingOnboarding: .constant(true))
    }
}
