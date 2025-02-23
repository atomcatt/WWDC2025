//
//  WindowSceneView.swift
//  SimpleClock
//
//  Created by 张晋恺 on 2025/2/3.
//

import SwiftUI
import Combine

struct WindowSceneView : View {
    @ObservedObject var viewModel: SceneViewModel
    
    @State private var colorTemperature: Color = .white // 色温
    @State private var brightness: CGFloat = 1.0        // 亮度（100%）
        
    @State private var currentTimeOfDay: String = "Day"
    @State private var timerSubscription: Cancellable?
    
    private let earlyMorningStart = 6
    private let dayStart = 8
    private let eveningStart = 18
    private let nightStart = 20
    
    var body: some View {
        GeometryReader { geo in
            let screenWidth = geo.size.width
            let screenHeight = geo.size.height
            let scale: CGFloat = 2
            
            ZStack(alignment: .topLeading) {
                WindowSystemCenterView(viewModel: viewModel, screenWidth: screenWidth, screenHeight: screenHeight)
                    .scaleEffect(scale)
            }
            .onDisappear {
                timerSubscription?.cancel()
            }
        }
    }
}
