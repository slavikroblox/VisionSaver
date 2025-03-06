//
//  TabMenu.swift
//  VisionSaver
//
//  Created by Vyacheslav on 03.03.2025.
//

import SwiftUI

struct TabMenu: View {
    @ObservedObject var advanced: Advanced
    
    var body: some View {
        TabView {
            ContentView(counter: Counter(advanced: advanced), advanced: advanced)
                .tabItem {
                    Text("Main")
                }
            
            AdvancedView(advanced: advanced)
                .tabItem {
                    Text("Advanced")
                }
        } .frame(width: 300, height: 150)
    }
}

#Preview {
    TabMenu(advanced: Advanced())
}
