//
//  File.swift
//  iOS-1-Final-Exam
//
//  Created by Fenil Bhanavadiya on 2022-12-17.
//

import Foundation
import UIKit

class CalendarHelper {
    
    let calender = Calendar.current
    
    func plusMonth(date: Date) -> Date {
        return calender.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date {
        return calender.date(byAdding: .month, value: -1, to: date)!
    }
    
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int {
        let range = calender.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func daysOfMonth(date: Date) -> Int {
        let component = calender.dateComponents([.day], from: date)
        return component.day!
    }
    
    func firstOfMonth(date: Date) -> Date {
        let component = calender.dateComponents([.year, .month], from: date)
        return calender.date(from: component)!
    }
    
    func weekDay(date: Date) -> Int {
        let component = calender.dateComponents([.weekday], from: date)
        return component.weekday! - 1
    }
    
}
