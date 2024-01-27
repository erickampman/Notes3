//
//  TopicListView.swift
//  Notes3
//
//  Created by Eric Kampman on 1/26/24.
//

import SwiftUI
import SwiftData

struct TopicListView: View {
	@Environment(NavigationContext.self) private var navigationContext
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \Topic.title) private var topics: [Topic]
	@State var showAddTopic = false
	@State var showAddNote = false

    var body: some View {
		@Bindable var navigationContext = navigationContext
		List(selection: $navigationContext.selectedTopicTitle) {
			ListTopics(topics: topics)
		}
		.sheet(isPresented: $showAddTopic, content: {
			AddTopicView()
				.presentationDetents([.medium])
		})
		.toolbar {
			ToolbarItem(placement: .principal) {
				Button(action: {
					showAddTopic.toggle()
				}, label: {
					Text("New Topic")
				})
			}
		}
		.sheet(isPresented: $showAddNote, content: {
			AddNoteView()
				.presentationDetents([.medium])
		})
		.toolbar {
			ToolbarItem(placement: .principal) {
				Button(action: {
					showAddNote.toggle()
				}, label: {
					Text("New Note")
				})
			}
		}
		.task {
			if topics.isEmpty {
				Topic.insertSampleData(modelContext: modelContext)
			}
		}
    }
}

private struct ListTopics: View {
	var topics: [Topic]
	
	var body: some View {
		ForEach(topics) { topic in
			NavigationLink(topic.title, value: topic.title)
		}
	}
}

//#Preview {
//	let config = ModelConfiguration(isStoredInMemoryOnly: true)
//	let container = try! ModelContainer(for: Topic.self, configurations: config)
//
//    return TopicListView()
//}