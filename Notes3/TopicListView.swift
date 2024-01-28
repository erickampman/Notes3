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
//	@Binding var noteSortOrder: [SortDescriptor<Note>]
	
    var body: some View {
		@Bindable var navigationContext = navigationContext
		List(selection: $navigationContext.selectedTopicTitle) {
			ForEach(topics) { topic in
				NavigationLink(topic.title, value: topic.title)
			}
		}
		#if false  /* enable to clear out the data */
		.toolbar {
			ToolbarItem(placement: .principal) {
				Button(action: {
					do {
						try modelContext.delete(model: Topic.self)
						try modelContext.delete(model: Note.self)
					}
					catch {
						print("clear error")
					}
				}, label: {
					Image(systemName: "minus")
				})
			}
		}
		#endif
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
		.task {
			if topics.isEmpty {
				Topic.insertSampleData(modelContext: modelContext)
			}
		}
    }
}

//#Preview {
//	let config = ModelConfiguration(isStoredInMemoryOnly: true)
//	let container = try! ModelContainer(for: Topic.self, configurations: config)
//
//    return TopicListView()
//}
