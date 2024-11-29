//
//  File.swift
//  JHApp
//
//  Created by Егорио on 27.11.2024.
//

import Foundation

struct GreetingModel {
    
    static func getGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12:
            return "Доброе утро,"
        case 12..<18:
            return "Добрый день,"
        case 18..<23:
            return "Добрый вечер,"
        default:
            return "Доброй ночи,"
        }
    }
}
