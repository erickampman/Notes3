//
//  NoteListView.swift
//  Notes3
//
//  Created by Eric Kampman on 1/27/24.
//

import SwiftUI
import SwiftData

struct NoteListView: View {
	@Environment(NavigationContext.self) private var navigationContext
	@Environment(\.modelContext) var modelContext
	
	var topicTitle: String

	@Query(sort: \Note.title) private var notes: [Note]

	init(topicTitle: String) {
		self.topicTitle = topicTitle
		let predicate = #Predicate<Note> { note in
			note.topic.title == topicTitle
		}
		_notes = Query(filter: predicate, sort: \Note.title)
	}

	var body: some View {
		@Bindable var navigationContext = navigationContext
		NavigationStack {
			if notes.isEmpty {
				Text("Add Notes")
			} else {
				List(selection: $navigationContext.selectedNoteTitle) {
					ForEach(notes) { note in
						NavigationLink(destination: NoteView(noteTitle: note.title)) {
							Text(note.title)
						}
					}
				}
			}
		}
		.navigationTitle("Note Selection")
    }
}

#Preview {
    NoteListView(topicTitle: "Foobar")
}
