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
					NoteListView(topicTitle: selectedTopicTitle)
				} else {
					Text("Select Topic")
				}
				updateSelectionInfo(navigationContext.selectedTopicTitle)
			}
		} detail: {
			NoteView(note: navigationContext.selectedNote)
		}
    }
	
	private func updateSelectionInfo(_ topicTitle: String?) -> some View {
		if prevTopicTitle != topicTitle {
			DispatchQueue.main.async {
				navigationContext.selectedNote = nil
				prevTopicTitle = topicTitle
			}
		}
		return EmptyView()
	}

}

//#Preview {
//	@State var columnVisibility: NavigationSplitViewVisibility = .all
//    return ThreeColumnContentView(columnVisibility: columnVisibility)
//}
