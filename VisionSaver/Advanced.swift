//
//  Advanced.swift
//  VisionSaver
//
//  Created by Vyacheslav on 03.03.2025.
//

import Foundation
import Combine

class Advanced: ObservableObject {
    @Published public var title: String = "Time for a rest!"
    @Published public var message: String = "Please take a break, look in the window for 20 seconds."
}
