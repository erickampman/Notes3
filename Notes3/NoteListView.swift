//
//  NoteListView.swift
//  Notes3
//
//  Created by Eric Kampman on 1/27/24.
//

import SwiftUI
import SwiftData

enum SortBy {
	case title
	case date
}

struct NoteListView: View {
	@Environment(NavigationContext.self) private var navigationContext
	@Environment(\.modelContext) var modelContext
	@State var showAddNote = false
	var noteSortOrder: [SortDescriptor<Note>]

	@State private var sortedNotes = [Note]()

	var topicTitle: String

	@Query(sort: \Note.title) private var notes: [Note]
	
	init(topicTitle: String, noteSortOrder: [SortDescriptor<Note>]) {
		self.noteSortOrder = noteSortOrder
		self.topicTitle = topicTitle
		let predicate = #Predicate<Note> { note in
			note.topic.title == topicTitle
		}
		_notes = Query(filter: predicate, sort: noteSortOrder)
	}

	var body: some View {
		@Bindable var navigationContext = navigationContext
		NavigationStack {
			if notes.isEmpty {
				Text("Add Notes")
			} else {
				List(selection: $navigationContext.selectedNote) {
					ForEach(notes) { note in
						NavigationLink(note.title, value: note)
					}
					.onDelete(perform: removeNotes)
				}
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
    }
	
	private func removeNotes(at indexSet: IndexSet) {
		for index in indexSet {
			let noteToDelete = notes[index]
			if navigationContext.selectedNote?.persistentModelID == noteToDelete.persistentModelID {
				navigationContext.selectedNote = nil
			}
			modelContext.delete(noteToDelete)
		}
	}
}

#Preview {
    NoteListView(topicTitle: "Foobar", noteSortOrder: [SortDescriptor(\Note.title)])
}
