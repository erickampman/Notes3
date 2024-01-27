//
//  AddNoteView.swift
//  Notes3
//
//  Created by Eric Kampman on 1/27/24.
//

import SwiftUI
import SwiftData

struct AddNoteView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext

	@State private var title = ""
	@State private var text = ""
	@State private var selectedTopic: Topic?
	
	@Query(sort: \Topic.title) private var topics: [Topic]

    var body: some View {
		NavigationStack {
			Form {
				Picker("Topic", selection: $selectedTopic) {
					Text("Select a topic").tag(nil as Topic?)
					ForEach(topics) { topic in
						Text(topic.title).tag(topic as Topic?)
					}
				}
				TextField("Title", text: $title)
				TextField("Notes", text: $text, axis: .vertical)
					.lineLimit(5...25)
					.frame(minWidth: 300)
				
			}
			.padding()
			.toolbar {
				ToolbarItem(placement: .principal) {
					Text("Add Note")
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button("Save") {
						withAnimation {
							let note = Note(title: title, text: text, topic: selectedTopic!)
							modelContext.insert(note)
							dismiss()
						}
					}
					.disabled(title.isEmpty || selectedTopic == nil)
				}
				
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel", role: .cancel) {
						dismiss()
					}
				}
			}

		}
	 }
}

#Preview {
    AddNoteView()
}
