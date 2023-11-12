//
//  JailBreakCheck.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 18/10/23.
//

import Foundation
class JailBreakCheck: NSObject {
    
    static func checkForJailBreakDevice() -> Bool {
        // Check for Files created after jail break
        if(FileManager.default.fileExists(atPath: "/private/var/lib/apt")) 
            || (FileManager.default.fileExists(atPath: "/Applications/Cydia.app")) {
            return true
        }
        // Check if we can write a file outside sandbox
        let jailBreakTestText = "Test for JailBreak"
        do {
            try jailBreakTestText.write(toFile:"/private/jailBreakTestText.txt", 
                                        atomically:true, encoding:String.Encoding.utf8)
            return true
        } catch {}
        return false
    }
}
