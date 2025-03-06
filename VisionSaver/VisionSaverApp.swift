//
//  VisionSaverApp.swift
//  VisionSaver
//
//  Created by Vyacheslav on 01.03.2025.
//

import SwiftUI

@main
struct VisionSaverApp: App {
    let advancedInstance = Advanced()
    
    var body: some Scene {
        WindowGroup {
            TabMenu(advanced: advancedInstance)
        }
    }
}
