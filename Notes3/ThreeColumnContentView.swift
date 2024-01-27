//
//  ThreeColumnContentView.swift
//  Notes3
//
//  Created by Eric Kampman on 1/26/24.
//

import SwiftUI

struct ThreeColumnContentView: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(NavigationContext.self) private var navigationContext
	@State var columnVisibility: NavigationSplitViewVisibility = .all

    var body: some View {
		NavigationSplitView(columnVisibility: $columnVisibility) {
//			Text("Topics")
			TopicListView()
		} content: {
			if let selectedTopicTitle = navigationContext.selectedTopicTitle {
				NoteListView(topicTitle: selectedTopicTitle)
			} else {
				Text("Select Topic")
			}
		} detail: {
			if let selectedNote = navigationContext.selectedNote {
				NoteView(note: selectedNote)
			} else {
				Text("NoteDetail")
			}
		}

    }
}

//#Preview {
//	@State var columnVisibility: NavigationSplitViewVisibility = .all
//    return ThreeColumnContentView(columnVisibility: columnVisibility)
//}
