//
//  NavigationContext.swift
//  Notes3
//
//  Created by Eric Kampman on 1/26/24.
//

import SwiftUI

@Observable
class NavigationContext {
	var selectedTopicTitle: String?
	var selectedNote: Note?
	var columnVisibility: NavigationSplitViewVisibility
	
	init(selectedTopicTitle: String? = nil, selectedNote: Note? = nil, columnVisibility: NavigationSplitViewVisibility  = .automatic) {
		self.selectedTopicTitle = selectedTopicTitle
		self.selectedNote = selectedNote
		self.columnVisibility = columnVisibility
	}
}
