import SwiftUI

@main
struct SimpleClockApp: App {
    init() {
        // 启动时强制横屏
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
