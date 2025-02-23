//
//  SwitchView.swift
//  SimpleClock
//
//  Created by 张晋恺 on 2025/2/3.
//

// Implement in IndoorSceneView.swift, it should be seperated from IndoorSceneView.swift to here.
import SwiftUI

struct LightSwitchView: View {
    @ObservedObject var viewModel: SceneViewModel
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    @State private var rotationAngle: CGFloat = 0
    
    var body: some View {
        let offset = screenHeight * 1/4 * tan(60 * .pi / 180)
        let start = CGPoint(
            x: screenWidth * 1/15 + offset,
            y: 0
        )
        let end = CGPoint(
            x: start.x,
            y: screenHeight * 6/10
        )

        ZStack {
            Path {path in
                let rectWidth: CGFloat = 25
                let rectHeight: CGFloat = 85
                let radius: CGFloat = rectWidth / 2
                path.move(to: CGPoint(x: end.x - rectWidth / 2, y: end.y + radius))
                path.addArc(center: CGPoint(x: end.x, y: end.y + radius),
                            radius: radius,
                            startAngle: .degrees(180),
                            endAngle: .degrees(360),
                            clockwise: false
                )
                
                path.move(to: CGPoint(x: end.x - rectWidth / 2, y: end.y + rectHeight))
                path.addArc(center: CGPoint(x: end.x, y: end.y + rectHeight),
                            radius: radius,
                            startAngle: .degrees(180),
                            endAngle: .degrees(360),
                            clockwise: true
                )
                path.move(to: CGPoint(x: end.x - rectWidth / 2, y: end.y + radius))
                path.addLine(to: CGPoint(x: end.x - rectWidth / 2, y: end.y + rectHeight))
                path.addLine(to: CGPoint(x: end.x + rectWidth / 2, y: end.y + rectHeight))
                path.addLine(to: CGPoint(x: end.x + rectWidth / 2, y: end.y + radius))
            }
            .fill(Color.white)
            .rotationEffect(Angle(degrees: Double(rotationAngle)), anchor: .init(x: start.x / screenWidth, y: start.y / screenHeight))
            
            Path { path in
                path.move(to: start)
                path.addLine(to: end)
            }
            .stroke(Color.white, lineWidth: 5)
            .rotationEffect(Angle(degrees: Double(rotationAngle)), anchor: .init(x: start.x / screenWidth, y: start.y / screenHeight))
        }
        .frame(width: screenWidth, height: screenHeight)
        .onAppear {
                // 在视图出现时启动定时器动画
                startAnimationTimer()
        }
        .onTapGesture {
            viewModel.toggleScene()
//            viewModel.toggleLightMode()
        }
    }
    
    private func startAnimationTimer() {
        // 每10秒触发一次动画
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    rotationAngle -= 2 // 每次旋转5度
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    rotationAngle += 4
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    rotationAngle = 0 // 恢复到原角度
                }
            }
        }
    }
}
