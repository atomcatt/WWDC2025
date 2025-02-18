//
//  SceneViewModel.swift
//  SimpleClock
//
//  Created by 张晋恺 on 2025/2/3.
//

import SwiftUI
import Combine

class SceneViewModel: ObservableObject {
    enum SceneState {
        case IndoorSceneDark
        case IndoorSceneLight
        case WindowScene
    }
    
    @Published var currentScene: SceneState = .IndoorSceneDark
    @Published var curtainHeight: CGFloat = 235
    @Published var backgroundColor: Color = .black // 背景颜色
    @Published var isPlayingAudio = false          // 音频播放状态
    @Published var switchWiggle = false            // 开关晃动状态
    @Published var transitionProgress: CGFloat = 0 // 场景过渡进度
    
//    @Published var zoomScale: CGFloat = 1.0
//    @Published var zoomAnchor: UnitPoint = .center
    @Published var viewOffset: CGSize = .zero
    @Published var isAnimating = false
    
    
    public let globalMaxCurtainHeight: CGFloat = 235
    
    private let maxCurtainHeight: CGFloat = 235
    private let minCurtainHeight: CGFloat = 20
    
    func toggleScene() {
        withAnimation(.easeInOut(duration: 2)) {
            if (curtainHeight == maxCurtainHeight) {
                curtainHeight = minCurtainHeight
            } else {
                if (currentScene == .WindowScene) {
                    curtainHeight = minCurtainHeight
                } else {
                    curtainHeight = maxCurtainHeight
                }
            }
            self.currentScene = (self.currentScene == .IndoorSceneDark) ?  .WindowScene : (self.currentScene == .WindowScene ? .IndoorSceneLight : .IndoorSceneDark)
        }
    }
    
    @MainActor
    func toggleLightMode() {
        withAnimation(.easeInOut(duration: 2)) {
            curtainHeight = (curtainHeight == maxCurtainHeight) ? minCurtainHeight : maxCurtainHeight
        }
//        withAnimation(.easeInOut(duration: 2)) {
//            zoomScale = currentScene == .IndoorSceneDark ? 0.8 : 1.0
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 2)) {
                self.currentScene = (self.currentScene == .IndoorSceneDark) ? .IndoorSceneLight : .IndoorSceneDark
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeInOut(duration: 2)) {
                self.currentScene = (self.currentScene == .IndoorSceneLight) ? .WindowScene : .IndoorSceneDark
            }
        }
    }

    
    func startWiggle() {
        switchWiggle = true
    }
    
    func stopWiggle() {
        switchWiggle = false
    }
    
    func toggleAudio() {
        isPlayingAudio.toggle()
    }
    
    func calculateScene2Color() -> Color {
        let progress = transitionProgress
        return Color(
            red: progress,
            green: progress * 0.9,
            blue: progress * 0.8
        )
    }
}
