import Foundation

struct English: Locale {
    func missingPermissions() -> String {
        return "Tajpi can't run due to lacking permissions";
    }
    
    func fixMissingPermisions() -> String {
        return "Instructions for fixing permissions";
    }
    
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
    
    func modeAutomaticTransformX() -> String {
        return "Transform sx";
    }
    
    func modeAutomaticTransformH() -> String {
        return "Transform sh";
    }
    
    func changeLanguage() -> String {
        return "Change language";
    }
    
    func quit() -> String {
        return "Quit";
    }
    
}
