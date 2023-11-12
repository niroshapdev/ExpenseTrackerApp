//
//  Logger.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 28/10/23.
//

import Foundation

enum LogLevel: String {
    case info = "[INFO]"
    case warning = "[WARNING]"
    case error = "[ERROR]"
}

class Logger {
    static func log(_ message: String, level: LogLevel = .info, file: String = #file,
                    line: Int = #line, function: String = #function) {
        let fileName = (file as NSString).lastPathComponent
        let logMessage = "\(level.rawValue) \(fileName):\(line) \(function) - \(message)"
        print(logMessage)
    }
}
