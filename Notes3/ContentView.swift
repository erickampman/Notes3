//
//  ContentView.swift
//  Notes3
//
//  Created by Eric Kampman on 1/26/24.
//

import SwiftUI

struct ContentView: View {
	@State private var navigationContext = NavigationContext()

    var body: some View {
		ThreeColumnContentView()
			.environment(navigationContext)
    }
}

#Preview {
    ContentView()
}
