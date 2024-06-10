import Foundation
import Cocoa
import CoreGraphics
import Dispatch

var hasPrivilege = false;

func runEsperantaKlavaro() {
    
    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (t) in
        let hasPrivilegeNew = AXIsProcessTrusted();

        
        if hasPrivilegeNew && !hasPrivilege {
            hasPrivilege = true;
            startKeyboardInterception();
            delegate.rerender();
        }
        
        if (!hasPrivilegeNew && hasPrivilege) {
            hasPrivilege = false;
            stopKeyboardInterception();
            delegate.rerender();
        }
        
        hasPrivilege = hasPrivilegeNew;
    }
}
