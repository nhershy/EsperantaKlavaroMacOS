import Foundation

protocol Locale {
    var name: String { get };
    
    func state(paused: Bool) -> String;
    func changeState(paused: Bool) -> String;
    
    func modes() -> String;
    func modeOption() -> String;
    func modeAutomaticTransformX() -> String;
    func modeAutomaticTransformH() -> String;
    
    func changeLanguage() -> String;
    
    func quit() -> String;
    
    func missingPermissions() -> String;
    func fixMissingPermisions() -> String;
}
