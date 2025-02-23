//
//  ClockView.swift
//  SimpleClock
//
//  Created by 张晋恺 on 2025/2/3.
//
import SwiftUI

struct ClockView: View {
    @State private var hours = ""
    @State private var minutes = ""
    @State private var blinkColon = true
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 0) {
            Text(hours)
                .font(.system(size: 24, weight: .bold, design: .monospaced))
                .foregroundColor(.black)
                .tracking(3)
            
            Text(blinkColon ? ":" : " ")
                .font(.system(size: 24, weight: .bold, design: .monospaced))
                .foregroundColor(.black)
                .tracking(3)
            
            Text(minutes)
                .font(.system(size: 24, weight: .bold, design: .monospaced))
                .foregroundColor(.black)
                .tracking(3)
        }
        .onReceive(timer) { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let timeString = formatter.string(from: Date())
            
            let newHours = String(timeString.prefix(2))
            let newMinutes = String(timeString.dropFirst(3).prefix(2))
            
            // Update only the changed part
            if newHours != hours {
                hours = newHours
            }
            if newMinutes != minutes {
                minutes = newMinutes
            }
            
            // Toggle the colon every second
            blinkColon.toggle()
        }
    }
}
