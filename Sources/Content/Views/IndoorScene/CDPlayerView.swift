//
//  CDPlayerView.swift
//  SimpleClock
//
//  Created by 张晋恺 on 2025/2/3.
//

// Implement in IndoorSceneView.swift, it should be seperated from IndoorSceneView.swift to here.
import SwiftUI

struct CDPlayerView: View {
    @ObservedObject var audioPlayer : AudioPlayer
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    
    var body: some View {
        let cdSize = screenWidth * 0.1
        
        ZStack {
            // CD机主体
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray)
                .frame(width: cdSize, height: cdSize)
            
            // CD光盘
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.white, lineWidth: 35)
                .frame(width: cdSize * 0.45)
//                .offset(x: cdSize * 0.05)
            
            // 控制按钮
            VStack {
                VStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 8)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 8)
                    Spacer()
                }
            }
            .frame(width: cdSize, height: cdSize)
            .offset(x: -50, y: 10)
            
        }
        .position(
            x: screenWidth * 0.44,
            y: screenHeight * 0.425
        )
        .onTapGesture {
            Task {
                await audioPlayer.togglePlayback()
            }
        }
    }
}
