//
//  OnBoardingView.swift
//  MySmartRestaurant
//
//  Created by Antonio Scognamiglio on 18/01/23.
//

import SwiftUI

struct OnBoardingView: View {
    
    @Binding var isShowingOnboarding: Bool
    @StateObject var viewModel = ViewModel()
    
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
                Picker("Indoor tables", selection: $viewModel.numberOfTables) {
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
                Picker("Outdoor tables", selection: $viewModel.numberOfOutDoorTables) {
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
                            do {
                                try await viewModel.pushTablesInDB()
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        BigButton(text: "Confirm")
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
