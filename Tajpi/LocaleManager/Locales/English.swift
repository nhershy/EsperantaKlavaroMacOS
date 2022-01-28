//
//  English.swift
//  Tajpi
//
//  Created by Fritiof Rusck on 2022-01-27.
//

import Foundation

struct English: Locale {
    var name: String = "English";
    
    func state(paused: Bool) -> String {
        return paused ? "Paused" : "Running";
    }
    
    func changeState(paused: Bool) -> String {
        return paused ? "Start" : "Pause";
    }
    
    func modes() -> String {
        return "Modes";
    }
    
    func modeOption() -> String {
        return "option + key";
    }
    
    func modeAutomaticTransform() -> String {
        return "Transform sh and sx";
    }
    
    func updateAvailable() -> String {
        return "New update available!";
    }
    
    func currentVersion(version: String) -> String {
        return "Version: " + version;
    }
    
    func foundABug() -> String {
        return "Found a bug?"
    }
    
    func changeLanguage() -> String {
        return "Change language";
    }
    
    func quit() -> String {
        return "Quit";
    }
    
    
    
}