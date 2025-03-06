//
//  ContentView.swift
//  VisionSaver
//
//  Created by Vyacheslav on 01.03.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State public var interval: Int = 20
    @State private var customIntervalString: String = ""
    @State public var customInterval: Int = 0
    
    var counter: Counter
    @StateObject var advanced = Advanced()
    
    var startButtonText: String = "Start"
    
    @State public var running: Bool = false
    @State public var paused: Bool = false
    
    @State private var isCustomInterval: Bool = false
    
    var body: some View {
        VStack {
            Picker("Interval", selection: $interval) {
                Text("10 minutes").tag(10)
                Text("15 minutes").tag(15)
                Text("20 minutes (recommended)").tag(20)
                Text("25 minutes").tag(25)
                Text("30 minutes").tag(30)
                Text("35 minutes").tag(35)
                Text("40 minutes").tag(40)
                Text("45 minutes").tag(45)
                Text("50 minutes").tag(50)
                Text("55 minutes").tag(55)
                Text("1 hour").tag(60)
                Text("Custom").tag(0)
            }
            .frame(width: 250)
            .padding()
            .onChange(of: interval) { newValue in
                isCustomInterval = (newValue == 0)
            }

            TextField("20 (minutes)", text: $customIntervalString)
                .onChange(of: customIntervalString) { newValue in
                    let filtered = newValue.filter { $0.isNumber }
                    customIntervalString = filtered

                    if let customValue = Int(filtered) {
                        customInterval = customValue
                    }
                }
                .disabled(!isCustomInterval)
                .textFieldStyle(.roundedBorder)
            
            Section {
                Button(action: {
                    if running {
                        if paused {
                            paused = false
                            counter.startCount(seconds: counter.currentCount, advanced: advanced)
                        } else {
                            paused = true
                            counter.stopCounting()
                        }
                    } else {
                        counter.startCount(seconds: isCustomInterval ? customInterval * 60 : interval * 60, advanced: advanced); running = true
                    }
                }, label: {
                    Text(running ? paused ? "Resume" : "Pause" : "Start")
                        .frame(width: 260)
                })
                
                Button(action: {
                    counter.stopCounting()
                    paused = false
                    running = false
                }, label: {
                    Text("Reset")
                        .frame(width: 260)
                })
            }
        } .padding(10)
    }
}

#Preview {
    ContentView(counter: Counter(advanced: Advanced()), advanced: Advanced())
        .environmentObject(Advanced())
}
