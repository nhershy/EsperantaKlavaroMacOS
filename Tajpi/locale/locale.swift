//
//  locale.swift
//  tajpi
//
//  Created by Fritiof Rusck on 2022-01-25.
//

import Foundation

protocol Locale {
    static func name() -> String
    func running(_ running: Bool) -> String
    func info(_ running: Bool) -> String
    func quit() -> String
    func language() -> String
    func mode() -> String
    func optionMode() -> String
    func automaticTransformMode() -> String
    func foundABug() -> String
    func newVersion() -> String
    func currentVersion(_ version: String) -> String
}
