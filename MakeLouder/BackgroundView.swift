//
//  BackgroundView.swift
//  MakeLouder
//
//  Created by Denis Evdokimov on 12/20/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("background")
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .ignoresSafeArea()
            .blur(radius: 45, opaque: true)
    }
}

#Preview {
    BackgroundView()
}
