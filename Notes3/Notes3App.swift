//
//  Notes3App.swift
//  Notes3
//
//  Created by Eric Kampman on 1/26/24.
//

import SwiftUI
import SwiftData

@main
struct Notes3App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
		.modelContainer(for: Topic.self)
    }
}
