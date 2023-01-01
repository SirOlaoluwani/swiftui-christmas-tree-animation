//
//  ContentView.swift
//  ChrismasTree
//
//  Created by Olaoluwani Onafowope on 01/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isSpinning = false
    @State private var reposition = false
    @State private var showStar = false
    
    var circleSize: Double = 50
    var initialPosition: Double = 200
    
    let gradientThreeColors = Gradient(stops: [
        .init(color: Color.yellow, location: 0.2),
        .init(color: Color.yellow, location: 0.4),
        .init(color: Color.red, location: 0.8)
    ])
    
    func calcSize(el: Double) -> Double {
        return circleSize * (el / 1.5)
    }
    
    func calcPosition(el: Double) -> Double {
        if !reposition {
            return initialPosition
        }
        return 40 * el - initialPosition
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                ZStack {
                    Image(systemName: "star")
                        .font(.system(size: 40))
                        .foregroundStyle(
                            LinearGradient(colors: [.yellow, .yellow, .red], startPoint: isSpinning ? .topLeading : .bottomLeading, endPoint: isSpinning ? .bottomTrailing : .topTrailing)
                        )
                        .shadow(color: .yellow, radius: 10)
                        .shadow(color: .yellow, radius: 10)
                        .shadow(color: .yellow, radius: 10)
                        .hueRotation(
                            .degrees(isSpinning ? 0 : 340)
                        )
                        .animation(
                            .linear(duration: 1.5)
                            .repeatForever(
                                autoreverses: false)
                            .delay(0.2),
                            value: isSpinning
                        )
                        .opacity(!showStar ? 0: 1)
                }
                .offset(y: -200)
                
                ForEach(1 ..< 11) { el in
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 3)
                            .frame(width: calcSize(el: Double(el)), height: calcSize(el: Double(el)))
                            .foregroundColor(Color.gray)
                            
                            ForEach(0 ..< 4) {
                                Circle()
                                    .foregroundColor(.red)
                                    .shadow(color: .red, radius: 15)
                                    .shadow(color: .red, radius: 15)
                                    .shadow(color: .red, radius: 15)
                                    .hueRotation(.degrees(isSpinning ? Double($0) * 310 : Double($0) * 50))
                                    .offset(y: -(calcSize(el: Double(el))/2))
                                    .rotationEffect(.degrees(Double($0) * -90))
                                    .rotationEffect(.degrees(isSpinning ? 0 : -180))
                                    .frame(width: 6, height: 6)
                                    .animation(
                                        .linear(duration: 1.5).repeatForever(autoreverses: false)
                                        .delay(0.1 * Double(el)),
                                    value: isSpinning)
                                    
                            }
                    }
                    .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
                    .offset(y: calcPosition(el: Double(el)))
                }
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isSpinning.toggle()
                    
                    withAnimation(.easeInOut(duration: 2).delay(2)) {
                        reposition.toggle()
                    }
                    withAnimation(.easeInOut(duration: 6).delay(2.5)) {
                        showStar.toggle()
                    }
                }
            }
            
            Divider()
            Spacer()
        }
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
