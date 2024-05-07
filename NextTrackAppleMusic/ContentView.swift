//
//  ContentView.swift
//  NextTrackAppleMusic
//
//  Created by Anna Fadieieva on 2024-05-07.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NextTrackButton(triangliWidth: 50, duration: 0.6)
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}

struct NextTrackButton: View {

    @State var isPlaying: Bool = false

    let triangliWidth: CGFloat
    let duration: Double

    var body: some View {
        Button {
            isPlaying.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.isPlaying.toggle()
            }
        } label: {
            Group {
                HStack(spacing: 0) {
                    rightArrow
                        .frame(width: 0, height: 0)
                        .scaleEffect(isPlaying ? .init(width: 1, height: 1) : .zero)
                        .offset(x: isPlaying ? triangliWidth / 2 : 0, y: 0)
                        .opacity(isPlaying ? 1 : 0)
                    rightArrow
                        .offset(x: isPlaying ? triangliWidth : 0, y: 0)
                        .opacity(1)
                    rightArrow
                        .scaleEffect(isPlaying ? .zero : .init(width: 1, height: 1))
                        .offset(x: isPlaying ? 0.4 * triangliWidth : 0, y: 0)
                        .opacity(isPlaying ? 0 : 1)
                }
                .animation(isPlaying ? .spring(response: duration, dampingFraction: 0.7, blendDuration: duration) : nil, value: isPlaying)
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }

    private var rightArrow: some View {
        Image(systemName: "arrowtriangle.right.fill")
            .resizable()
            .renderingMode(.original)
            .frame(width: triangliWidth, height: triangliWidth, alignment: .center)
            .foregroundColor(.blue)
    }
}

struct ScaleButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
