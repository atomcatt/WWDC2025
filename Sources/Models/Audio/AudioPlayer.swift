//
//  AudioPlayer.swift
//  SimpleClock
//
//  Created by 张晋恺 on 2025/2/3.
//

// AudioPlayer.swift
import AVFoundation
import Combine
import Foundation

/// 音频播放管理器
actor AudioPlayer : ObservableObject {
    static let shared = AudioPlayer()
    private var player: AVAudioPlayer?
    
    /// 切换播放状态
    func togglePlayback() async {
        if player?.isPlaying == true {
            await stop()
        } else {
            await play()
        }
    }
    
    /// 开始播放
    private func play() async {
        guard let url = Bundle.main.url(
            forResource: "white_noise",
            withExtension: "mp3"
        ) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
            print("音频播放器初始化成功")
        } catch {
            print("音频播放失败: \(error.localizedDescription)")
        }
    }
    
    /// 停止播放
    func stop() async {
        player?.stop()
        player = nil
    }
    
    func isPlaying() async -> Bool {
        return player?.isPlaying ?? false
    }
}
