//
//  WindowView.swift
//  SimpleClock
//
//  Created by 张晋恺 on 2025/2/3.
//

// Implement in IndoorSceneView.swift, it should be seperated from IndoorSceneView.swift to here.
import SwiftUI

struct WindowSystemView: View {
    @ObservedObject var viewModel: SceneViewModel
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    
    var body: some View {
        let windowWidth = screenWidth * 35/100
        let windowHeight = screenHeight * 33/100
        
        GeometryReader { geometry in
            let windowFrame = geometry.frame(in: .global)
            let windowCenter = CGPoint(
                x: windowFrame.midX,
                y: windowFrame.midY
            )
//            let windowCenter = geometry.frame(in: .global).center
            let normalizedX = windowCenter.x / UIScreen.main.bounds.width
            let normalizedY = windowCenter.y / UIScreen.main.bounds.height
            
            VStack(spacing: 0) {
                // 窗户主体
                ZStack {
                    // 窗帘
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: windowWidth + screenWidth * 2/100, height: viewModel.curtainHeight)
                        .offset(y: -40 - (viewModel.globalMaxCurtainHeight - viewModel.curtainHeight)/2)
                        .animation(.easeInOut(duration: 1.0), value: viewModel.curtainHeight)
                    // 窗户背景
                    Rectangle()
                        .fill(Color.gray.opacity(0.6))
                        .frame(width: windowWidth, height: windowHeight)
                    
                    // 窗棂
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 10)
                        Spacer()
                    }
                    .frame(width: windowWidth, height: windowHeight)
                    
                    HStack(spacing: 0) {
                        Spacer()
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 10)
                    }
                    .frame(width: windowWidth, height: windowHeight)
                    
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 10)
                            Spacer()
                                .frame(width: geometry.size.width * 0.35)
                        }
                        .frame(width: windowWidth, height: windowHeight)
                    }
                    
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 10)
                        Spacer()
                    }
                    .frame(width: windowWidth, height: windowHeight)
                    
                    VStack(spacing: 0) {
                        Spacer()
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 10)
                    }
                    .frame(width: windowWidth, height: windowHeight)
                    
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 10)
                    }
                    .frame(width: windowWidth, height: windowHeight)
                    
                    // 窗台
                    Path { path in
                        let windowBottomX: CGFloat = 0
                        let windowBottomY = windowHeight
                        
                        // 梯形的宽度
                        let trapezoidHeight: CGFloat = 25
                        let topWidth: CGFloat = windowWidth  // 上边宽度
                        let bottomWidth: CGFloat = windowWidth * 1.2  // 下边宽度
                        
                        // 计算梯形的四个点
                        path.move(to: CGPoint(x: windowBottomX + (windowWidth - topWidth) / 2, y: windowBottomY))
                        path.addLine(to: CGPoint(x: windowBottomX + (windowWidth + topWidth) / 2, y: windowBottomY))
                        path.addLine(to: CGPoint(x: windowBottomX + (windowWidth + bottomWidth) / 2, y: windowBottomY + trapezoidHeight))
                        path.addLine(to: CGPoint(x: windowBottomX + (windowWidth - bottomWidth) / 2, y: windowBottomY + trapezoidHeight))
                        path.closeSubpath()
                    }
                    .fill(Color.gray)  // 窗台颜色
                    .offset(x: 13)
                    //             时钟
                    ClockView()
                        .frame(width: windowHeight * 0.5, height: windowHeight * 0.2)
                        .background(Color.white)
                        .padding(.top, 8)
                        .offset(x: 100, y: 110)
                }
                .frame(width: windowWidth, height: windowHeight)
                
                
            }
            .position(
                x: screenWidth * 0.7,
                y: screenHeight * 0.5
            )
            .onTapGesture {
                viewModel.toggleScene()
            }
            .onAppear {
//                viewModel.windowCenter = windowCenter
            }
        }
    }
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
