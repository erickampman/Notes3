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

	@State private var noteSortOrder = SortBy.title
	@State private var sortedNotes = [Note]()

	var topicTitle: String

	@Query(sort: \Note.title) private var notes: [Note]

	init(topicTitle: String) {
		self.topicTitle = topicTitle
		let predicate = #Predicate<Note> { note in
			note.topic.title == topicTitle
		}
		_notes = Query(filter: predicate, sort: \.title)
	}

	var body: some View {
		@Bindable var navigationContext = navigationContext
		NavigationStack {
			if notes.isEmpty {
				Text("Add Notes")
			} else {
				updateSortInfo()
				List(selection: $navigationContext.selectedNote) {
					ForEach(sortedNotes) { note in
						NavigationLink(note.title, value: note)
//						NavigationLink(destination: NoteView(note: note)) {
//							Text(note.title)
//						}
					}
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
			ToolbarItem {
				Picker("Sort Notes", selection: $noteSortOrder) {
					Text("Title")
						.tag(SortBy.title)
					Text("Date")
						.tag(SortBy.date)
				}
			}
		}
    }
	
	private func updateSortInfo() -> some View {
		DispatchQueue.main.async {
			sortedNotes = self.notes.sorted { a, b in
				switch (self.noteSortOrder) {
				case .title:
					a.title < b.title
				case .date:
					a.modificationDate > b.modificationDate
				}
			}
		}
		return EmptyView()
	}

}

#Preview {
    NoteListView(topicTitle: "Foobar")
}
