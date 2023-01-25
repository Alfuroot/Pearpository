//
//  TableSelectionView.swift
//  MySmartRestaurant
//
//  Created by Alessia Andrisani on 25/01/23.
//

import SwiftUI

struct TableSelectionView: View {
    var tableid: Int
    @State private var isTapped = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(isTapped ? .blue : .gray)
            Text("\(tableid)")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .onTapGesture {
            isTapped.toggle()
        }
    }
}

struct TableSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TableSelectionView(tableid: 1)
    }
}
