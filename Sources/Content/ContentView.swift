// ContentView.swift
import SwiftUI

/// 应用根视图，负责场景切换
struct ContentView: View {
    @StateObject var viewModel = SceneViewModel()
    @StateObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        Group {
            switch viewModel.currentScene {
            case .IndoorSceneDark:
                IndoorSceneView(viewModel: viewModel, audioPlayer: audioPlayer)
            case .IndoorSceneLight:
                IndoorSceneView(viewModel: viewModel, audioPlayer: audioPlayer)
                    .colorInvert()
            case .WindowScene:
                WindowSceneView(viewModel: viewModel)
                    .colorInvert()
            case .WindowSceneDark:
                WindowSceneView(viewModel: viewModel)
//                    .colorInvert()
            }
        }
        .animation(.easeInOut(duration: 2), value: viewModel.currentScene)
    }
}
