//
//  IndoorSceneView.swift
//  SimpleClock
//
//  Created by 张晋恺 on 2025/2/3.
//
import SwiftUI

struct IndoorSceneView : View {
    @ObservedObject var viewModel: SceneViewModel
    @ObservedObject var audioPlayer: AudioPlayer
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        GeometryReader { geo in
            let screenWidth = geo.size.width
            let screenHeight = geo.size.height
            
            ZStack(alignment: .topLeading) {
                Color.black.edgesIgnoringSafeArea(.all)
                
                CeilingView(screenWidth: screenWidth, screenHeight: screenHeight)
                
                LightSwitchView(viewModel: viewModel, screenWidth: screenWidth, screenHeight: screenHeight)
                
                FloorView(screenWidth: screenWidth, screenHeight: screenHeight)
                               
                WindowSystemView(viewModel: viewModel, screenWidth: screenWidth, screenHeight: screenHeight)
                               
                CDPlayerView(audioPlayer: audioPlayer, screenWidth: screenWidth, screenHeight: screenHeight)
                    .onTapGesture {
                        viewModel.toggleAudio()
                    }
            }
            .offset(viewModel.viewOffset)
            .animation(
                .interpolatingSpring(mass: 1.0, stiffness: 100, damping: 15),
                value: viewModel.viewOffset
            )
            .coordinateSpace(name: "GlobalSpace")
            .scaleEffect(viewModel.zoomScale, anchor: viewModel.zoomAnchor)
            .animation(.easeInOut(duration: 1.0), value: viewModel.zoomScale)
        }
    }
}

// 天花板
struct CeilingView: View {
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    
    var body: some View {
        Path { path in
            let topWidth = screenWidth * 3/4
            let bottomWidth = screenWidth * 1/2
            let height = screenHeight * 1/4
            let leftAngle: CGFloat = 60
            let rightAngle: CGFloat = 170
            
            let topLeft = CGPoint(x: screenWidth * 1/15, y: 0)
            let topRight = CGPoint(x: topLeft.x + topWidth, y: 0)
            let bottomRight = CGPoint(
                x: topRight.x + height * tan(rightAngle * .pi / 180),
                y: height
            )
            let bottomLeft = CGPoint(
                x: topLeft.x + height * tan(leftAngle * .pi / 180),
                y: height
            )
            
            path.move(to: topLeft)
            path.addLine(to: topRight)
            path.addLine(to: bottomRight)
            path.addLine(to: bottomLeft)
            path.closeSubpath()
        }
        .fill(Color.gray)
    }
}

struct FloorView: View {
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    
    var body: some View {
        Path { path in
            let offset = screenHeight * 1/4 * tan(60 * .pi / 180)
            let topWidth = screenWidth - offset
            let bottomWidth = screenWidth * 7/10
            let height = screenWidth * 1/9
            
            let startPoint = CGPoint(x: screenWidth * 1/15 + offset, y: screenHeight - height)
            let topRight = CGPoint(x: screenWidth, y: screenHeight - height)
            let bottomRight = CGPoint(x: screenWidth, y: screenHeight)
            let bottomLeft = CGPoint(x: screenWidth * 12/100, y: screenHeight)
            
            path.move(to: startPoint)
            path.addLine(to: topRight)
            path.addLine(to: bottomRight)
            path.addLine(to: bottomLeft)
            path.closeSubpath()
        }
        .fill(Color.gray)
    }
}
