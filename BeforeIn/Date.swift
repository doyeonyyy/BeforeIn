//
//  Date.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/21/23.
//

import Foundation

extension Date {
    func toString(_ format: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.timeZone = TimeZone(identifier: "ko_KR")
            return dateFormatter.string(from: self)
    }
    
    func getTimeText() -> String {
        var timeText = ""
        let timeInterval = Date().timeIntervalSince(self)
        let seconds = Int(timeInterval)
        let minutes = Int(timeInterval / 60)
        let hours = Int(timeInterval / 3600)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self, to: Date())
        let days = components.day ?? 0
        if days > 7 {
            timeText = "\(self.toString("yyyy년 M월 d일"))"
        }
        else {
            if hours >= 24 {
                timeText = "\(days)일 전"
            }
            else if hours < 1 {
                if minutes >= 1 {
                    timeText = "\(minutes)분 전"
                }
                else if seconds <= 1 {
                    timeText = "방금"
                }
                else {
                    timeText = "\(seconds)초 전"
                }
            }
            else {
                timeText = "\(hours)시간 전"
            }
        }
        return timeText
    }
}
