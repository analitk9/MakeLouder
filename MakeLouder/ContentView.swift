//
//  ContentView.swift
//  MakeLouder
//
//  Created by Denis Evdokimov on 12/20/23.
//

import SwiftUI

struct ContentView: View {
    @State var volume: CGFloat = 0.5
    var body: some View {
       BackgroundView()
            .overlay {
                CustomSlider(currentVolume: $volume)
                    .frame(width: 100, height: 250)
            }
    }
}

#Preview {
    ContentView()
}
