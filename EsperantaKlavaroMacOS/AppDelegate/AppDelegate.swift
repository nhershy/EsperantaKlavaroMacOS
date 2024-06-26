import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem!
    var locale = LocaleState(id: "locale", value: English());
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Init Keyboard
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            let img = NSImage(named: NSImage.Name("StatusIcon"))!
            img.size = NSMakeSize(18.0, 18.0)
            button.image = img
        }
        
        rerender()
    }
    
    func rerender() {
        setupMenus();
    }
    
    @objc private func handleQuit() {
        NSApplication.shared.terminate(nil)
    }
    
    @objc func onMenuRunningClick() {
        // Invert if it's running or not
        paused.change(!paused.value)
        setupMenus()
    }
    
    @objc func fixNoAccessibility() {
        let url = URL(string: "https://github.com/PumpedSardines/Tajpi/blob/main/GIVE_ACCESS.md")!
        NSWorkspace.shared.open(url)
    }
    
    @objc func openBug() {
        let url = URL(string: "https://github.com/PumpedSardines/Tajpi/issues")!
        NSWorkspace.shared.open(url)
    }
    
    func setupMenus() {
        
        // Create the menu
        let menu = NSMenu()
        menu.autoenablesItems = false // This i needed for isEnabled to work
        
        
        if(!hasPrivilege) {
            let infoButton = NSMenuItem(title: locale.value.missingPermissions(), action: nil, keyEquivalent: "")
            infoButton.isEnabled = false
            
            let fixButton = NSMenuItem(title: locale.value.fixMissingPermisions(), action: #selector(fixNoAccessibility), keyEquivalent: "")
            
            menu.addItem(infoButton)
            menu.addItem(fixButton)
        } else {
            let modeMenu = getModeMenu();
            
            // Create a info text that diplays current status
            let info = NSMenuItem(title: locale.value.state(paused: paused.value), action: nil, keyEquivalent: "")
            info.isEnabled = false
            menu.addItem(info)
            
            menu.addItem(NSMenuItem.separator())
            
            let runningButton = NSMenuItem(title: locale.value.changeState(paused: paused.value), action: #selector(onMenuRunningClick), keyEquivalent: "")
            menu.addItem(runningButton)
            
            let modeButton = NSMenuItem(title: locale.value.modes(), action: nil, keyEquivalent: "")
            menu.addItem(modeButton)
            menu.setSubmenu(modeMenu, for: modeButton)
        }

        
        //============ Lower settings menu ============
        menu.addItem(NSMenuItem.separator())

        let localeMenu = getLocaleMenu();
        let languageButton = NSMenuItem(title: locale.value.changeLanguage(), action: nil, keyEquivalent: "")
        menu.addItem(languageButton)
        menu.setSubmenu(localeMenu, for: languageButton)
        
        menu.addItem(NSMenuItem.separator())
        
        // Add a quit button
        menu.addItem(NSMenuItem(title: locale.value.quit(), action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    @objc func setLanguageEnglish() {
        locale.change(English())
        setupMenus()
    }
    
    @objc func setLanguageEsperanto() {
        locale.change(Esperanto())
        setupMenus()
    }
    
    func getLocaleMenu() -> NSMenu {
        let menu = NSMenu();
        menu.autoenablesItems = true
        
        let languages = [
            // Language, function to switch, if it's selected
            (English(),  #selector(setLanguageEnglish), locale.value is English),
            (Esperanto(),  #selector(setLanguageEsperanto), locale.value is Esperanto),
        ] as [(Locale, Selector, Bool)];
        
        
        
        for language in languages {
            // Init English button
            let btn = NSMenuItem(title: language.0.name, action: language.1, keyEquivalent: "")
            btn.isEnabled = true;
            btn.state = .off
            if(language.2) {
                btn.state = .on
            }
            menu.addItem(btn);
        }
        
        return menu
    }
    
    @objc func setOptionMode() {
        option.change(!option.value);
        setupMenus()
    }
    
    @objc func setAutomaticTransformModeX() {
        automaticTransformX.change(!automaticTransformX.value);
        setupMenus()
    }
    
    @objc func setAutomaticTransformModeH() {
        automaticTransformH.change(!automaticTransformH.value);
        setupMenus()
    }
    
    func getModeMenu() -> NSMenu {
        let menu = NSMenu();
        menu.autoenablesItems = true
        
        // Init option mode button
        let optionButton = NSMenuItem(title: locale.value.modeOption(), action: #selector(setOptionMode) , keyEquivalent: "")
        optionButton.state = .off
        
        if(option.value) {
            optionButton.state = .on
        }
        
        // Init transform X button
        let automaticTransformButtonX = NSMenuItem(title: locale.value.modeAutomaticTransformX(), action: #selector(setAutomaticTransformModeX) , keyEquivalent: "")
        automaticTransformButtonX.state = .off
        if(automaticTransformX.value) {
            automaticTransformButtonX.state = .on
        }
        
        // Init transform H button
        let automaticTransformButtonH = NSMenuItem(title: locale.value.modeAutomaticTransformH(), action: #selector(setAutomaticTransformModeH) , keyEquivalent: "")
        automaticTransformButtonH.state = .off
        if(automaticTransformH.value) {
            automaticTransformButtonH.state = .on
        }
        
        menu.addItem(optionButton);
        menu.addItem(automaticTransformButtonX);
        menu.addItem(automaticTransformButtonH);
        
        return menu
    }
}
