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
	@State var prevTopicTitle: String?
	@State private var noteSortOrder = [
		SortDescriptor(\Note.title),
		SortDescriptor(\Note.modificationDate),
	]

    var body: some View {
		NavigationSplitView(columnVisibility: $columnVisibility) {
//			Text("Topics")
			TopicListView()
		} content: {
			ZStack {
				if let selectedTopicTitle = navigationContext.selectedTopicTitle {
					NoteListView(topicTitle: selectedTopicTitle, noteSortOrder: noteSortOrder)
				} else {
					Text("Select Topic")
				}
			}
		} detail: {
			NoteView(note: navigationContext.selectedNote)
		}
		.toolbar {
			ToolbarItem {
				Picker("Sort", selection: $noteSortOrder) {
					Text("Sort by Title")
						.tag([
							SortDescriptor(\Note.title),
							SortDescriptor(\Note.modificationDate, order: .reverse),
						])
					
					Text("Sort by Date")
						.tag([
							SortDescriptor(\Note.modificationDate, order: .reverse),
							SortDescriptor(\Note.title),
						])
				}
			}
		}
		.onChange(of: navigationContext.selectedTopicTitle, initial: true) {
			navigationContext.selectedNote = nil
		}
    }

}

//#Preview {
//	@State var columnVisibility: NavigationSplitViewVisibility = .all
//    return ThreeColumnContentView(columnVisibility: columnVisibility)
//}
