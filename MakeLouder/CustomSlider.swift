//
//  CustomSlider.swift
//  MakeLouder
//
//  Created by Denis Evdokimov on 12/20/23.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var currentVolume: CGFloat
    @State private var lastVolume = 0.0
    @State private var scaleWidth = 1.0
    @State private var scaleHeight = 1.0
    @State private var ancorSide: UnitPoint = .zero
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(.white)
                        .scaleEffect(y: currentVolume, anchor: .bottom)
                }
                .clipShape(RoundedRectangle(cornerRadius: 18,style: .continuous))
                .frame(width: size.width, height: size.height)
                .scaleEffect(x: scaleWidth, y: scaleHeight, anchor: ancorSide)
                .gesture(
                    LongPressGesture(minimumDuration: 0.0).onEnded({ _ in
                        lastVolume = currentVolume
                    }).simultaneously(with:  DragGesture().onChanged({ value in
                        var progress = calcProgress(for: size, gesture: value)
                        updateScaleValue(progress)
                        progress = max(0, progress)
                        progress = min(1, progress)
                        currentVolume =   progress
                    }).onEnded({ value in
                        lastVolume = currentVolume
                        withAnimation {
                            scaleWidth = 1.0
                            scaleHeight = 1.0
                        }
                    }))
                )
        }
    }
    
    private func calcProgress(for size: CGSize, gesture: DragGesture.Value)-> Double {
        let startLocation =  gesture.startLocation.y
        let currentLocation = gesture.location.y
        let offset =  startLocation - currentLocation
        let progress = (offset / size.height) + lastVolume
        return progress
    }
    
    private func updateScaleValue(_ progress: Double){
        let isDown = progress < 0 ? true : false
        let power = isDown ? (1 - progress) : (progress)
        switch progress {
        case _ where progress < 0 || progress > 1:
            scaleWidth = 1 / pow(power, 1/10)
            scaleHeight = pow(power, 1/8)
            ancorSide =  isDown ? .top : .bottom
        default:
            return
        }
    }
}

#Preview {
    ZStack{
        BackgroundView()
        CustomSlider(currentVolume: .constant(0.5))
            .frame(width: 100, height: 250)
    }
}
