import Foundation
import SwiftUI
import Swift

var paused = BoolState(id: "keyboard.pause", value: false);
var option = BoolState(id: "keyboard.option", value: true);
var automaticTransformX = BoolState(id: "keyboard.automaticTransformX", value: false);
var automaticTransformH = BoolState(id: "keyboard.automaticTransformH", value: false);

private var loop: CFRunLoop? = nil;
private var loopSource: CFRunLoopSource? = nil;
private var eventTap: CFMachPort? = nil;

func startKeyboardInterception() {
    
    let eventMask = (1 << CGEventType.keyDown.rawValue) | (1 << CGEventType.keyUp.rawValue) | (1 << CGEventType.flagsChanged.rawValue)
    eventTap = CGEvent.tapCreate(
        tap: .cgSessionEventTap,
        place: .headInsertEventTap,
        options: .defaultTap,
        eventsOfInterest: CGEventMask(eventMask),
        callback: keyboardCallback,
        userInfo: nil
    )
    
    guard let port = eventTap else { return  }
    
    loopSource = CFMachPortCreateRunLoopSource(kCFAllocatorSystemDefault, port, 0)
    guard let source = loopSource else { return  }
    
    loop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(loop, source, CFRunLoopMode.commonModes)
    CFRunLoopRun()
    
    CGEvent.tapEnable(tap: port, enable: true)
}

func stopKeyboardInterception() {
    if let port = eventTap {
        CGEvent.tapEnable(tap: port, enable: false)
    }
    
    CFRunLoopSourceInvalidate(loopSource);
    CFRunLoopStop(loop);
    CFMachPortInvalidate(eventTap)
}
