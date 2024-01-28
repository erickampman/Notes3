//
//  NoteView.swift
//  Notes3
//
//  Created by Eric Kampman on 1/27/24.
//

import SwiftUI

struct NoteView: View {
	var note: Note?
	@Environment(NavigationContext.self) private var navigationContext
	@Environment(\.modelContext) private var modelContext

	@State private var title = ""
	@State private var text = ""
	@State private var prevNote: Note?

	var body: some View {
		if let note = note {
			Form {
				Text("Topic: \(note.topic.title)")
					.font(.title3)
				TextField("Title", text: $title)
				TextField("Text", text: $text, axis: .vertical)
					.frame(minWidth: 300)
					.lineLimit(5...25)
				Button("Save") {
					withAnimation {
						save()
					}
				}
			}
			.padding()
			.onChange(of: navigationContext.selectedNote, initial: true) { onote, nnote in
				updateTextForNote(nnote)
			}
		} else {
			VStack {
				Text("No Current Note")
				Text(navigationContext.selectedNote?.title ?? "None")
			}
			.onChange(of: navigationContext.selectedNote, initial: true) { onote, nnote in
				updateTextForNote(nnote)
			}
		}
	}
	private func save() {
		guard let note = note else { return }
		note.title = title
		note.text = text
		note.modificationDate = Date()
	}
	
	private func updateTextForNote(_ note: Note?) {
		if let note = note {
			title = note.title
			text = note.text
			prevNote = note
		} else {
			title = ""
			text = ""
			prevNote = nil
			
		}
	}
}

#Preview {
	NoteView(note: Note(title: "foo", text: "bar", topic: Topic(title: "title")))
}
