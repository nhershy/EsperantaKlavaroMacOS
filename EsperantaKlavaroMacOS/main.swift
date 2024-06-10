import Foundation
import SwiftUI

let app = NSApplication.shared

let delegate = AppDelegate()
app.delegate = delegate

runEsperantaKlavaro();

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
