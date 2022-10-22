//
//  CallMeth.swift
//  Final_Project_Cajiza_Dylan
//
//  Created by Aristoteles on 10/22/22.
//

import Foundation
import UIKit

class CallMeth{
    let calendar = Calendar.current
    
    func plusMonth(date: Date) -> Date{
        return calendar.date(byAdding: .month,value: 1, to: date)!
    }
    func minusMonth(date: Date) -> Date{
        return calendar.date(byAdding: .month,value: -1, to: date)!
    }
    
    func monthString(date: Date) -> String{
        
        let dFormat = DateFormatter()
        dFormat.dateFormat = "LLLL"
        
        return dFormat.string(from: date)
    }
    
    func yearString(date: Date) -> String{
        
        let dFormat = DateFormatter()
        dFormat.dateFormat = "yyyy"
        
        return dFormat.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int {
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func daysofMonth(date: Date) -> Int {
        
        let compon = calendar.dateComponents([.day], from: date)
        return compon.day!
    }
    
    func firstofMonth(date: Date) -> Date {
        
        let compon = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: compon)!
    }
    
    func weekDay(date: Date) -> Int {
        
        let compon = calendar.dateComponents([.weekday], from: date)
        return compon.weekday! - 1 
    }
}