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
    
    @Published var viewOffset: CGSize = .zero
    @Published var isAnimating = false
    
    @Published var isZoomed: Bool = false
    @Published var zoomScale: CGFloat = 1.0
    @Published var zoomAnchor: UnitPoint = .center
    @Published var windowCenter = UnitPoint(x: 0.9, y: 0.5)
    
    public let globalMaxCurtainHeight: CGFloat = 235
    
    private let maxCurtainHeight: CGFloat = 235
    private let minCurtainHeight: CGFloat = 20
    private let modeChangeFlag : Bool = false
    
    @MainActor
    func toggleScene() {
        DispatchQueue.main.asyncAfter(deadline: .now()){
            withAnimation(.easeInOut(duration: 1)) {
                if (self.curtainHeight == self.maxCurtainHeight) {
                    self.curtainHeight = self.minCurtainHeight
                } else {
                    if (self.currentScene == .WindowScene) {
                        self.curtainHeight = self.minCurtainHeight
                    } else {
                        self.curtainHeight = self.maxCurtainHeight
                    }
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeInOut(duration: 1)) {
                if (self.currentScene == .IndoorSceneDark) {
                    self.currentScene = .IndoorSceneLight
                } else if (self.currentScene == .IndoorSceneLight) {
                    self.currentScene = .IndoorSceneDark
                } else {
                    self.currentScene = .IndoorSceneLight
                    self.isZoomed = true
                    self.zoomScale = 2.0
                    self.zoomAnchor = self.windowCenter
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut(duration: 1)) {
                if (self.isZoomed == false && self.currentScene == .IndoorSceneLight) {
                    self.isZoomed = true
                    self.zoomScale = 2.0
                    self.zoomAnchor = self.windowCenter
                } else if (self.isZoomed == true){
                    self.isZoomed = false
                    self.zoomScale = 1.0
                    self.zoomAnchor = .center
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(.easeInOut(duration: 1)) {
//                self.currentScene = (self.currentScene == .IndoorSceneLight) ?  .WindowScene : (self.currentScene == .WindowScene ? .IndoorSceneLight : .IndoorSceneDark)
                if (self.currentScene == .IndoorSceneLight && self.isZoomed == true) {
                    self.currentScene = .WindowScene
                } else if (self.currentScene == .WindowScene) {
//                    self.currentScene = .IndoorSceneLight
                }
            }
        }
    }
    
    @MainActor
    func toggleLightMode() {
        withAnimation(.easeInOut(duration: 1)) {
            curtainHeight = (curtainHeight == maxCurtainHeight) ? minCurtainHeight : maxCurtainHeight
        }
        // 切换室内场景光线状态
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 1)) {
                self.currentScene = (self.currentScene == .IndoorSceneDark) ? .IndoorSceneLight : .IndoorSceneDark
            }
        }
        // 以窗户为中心缩放
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
            withAnimation(.easeInOut(duration: 1)) {
                if (self.isZoomed == false && self.currentScene == .IndoorSceneLight) {
                    self.isZoomed = true
                    self.zoomScale = 2.0 // 放大1.5倍
                    self.zoomAnchor = self.windowCenter
                } else if (self.isZoomed == true) {
                    self.isZoomed = false
                    self.zoomScale = 1 // 放大1.5倍
                    self.zoomAnchor = .center
                }
            }
        }
        // 切换场景
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
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
}
