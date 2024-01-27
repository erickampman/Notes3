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
	var selectedNoteTitle: String?
	var columnVisibility: NavigationSplitViewVisibility
	
	init(selectedTopicTitle: String? = nil, selectedNoteTitle: String? = nil, columnVisibility: NavigationSplitViewVisibility  = .automatic) {
		self.selectedTopicTitle = selectedTopicTitle
		self.selectedNoteTitle = selectedNoteTitle
		self.columnVisibility = columnVisibility
	}
}
