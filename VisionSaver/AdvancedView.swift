//
//  AdvancedView.swift
//  VisionSaver
//
//  Created by Vyacheslav on 03.03.2025.
//

import SwiftUI

struct AdvancedView: View {
    @ObservedObject var advanced: Advanced
    
    @State public var title: String = "Time for a rest!"
    @State public var message: String = "Please take a break, look in the window for 20 seconds."
    var body: some View {
        VStack {
            HStack {
                Text("Title")
                TextField(
                    "Title",
                    text: $advanced.title
                ) .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("Message")
                TextField(
                    "Message",
                    text: $advanced.message
                ) .textFieldStyle(.roundedBorder)
            }
        } .padding(10)
    }
}

#Preview {
    AdvancedView(advanced: Advanced())
}
