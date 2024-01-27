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
				updateTextForNote(note)
				Text(note.topic.title)
					.font(.title3)
				TextField("Title", text: $title)
				TextField("Text", text: $text)
					.frame(minWidth: 300)
					.lineLimit(5...25)
				Button("Save") {
					withAnimation {
						save()
					}
				}
			}
		} else {
			VStack {
				Text("No Current Note")
				updateTextForNote(note)
			}
		}
//		.onAppear {
//			if let note {
//				// Edit the incoming note.
//				title = note.title
//				text = note.text
//			}
//		}
	}
	private func save() {
		guard let note = note else { return }
		note.title = title
		note.text = text
	}
	
	private func updateTextForNote(_ note: Note?) -> some View {
		if prevNote != note {
			DispatchQueue.main.async {
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
		return EmptyView()
	}
}

#Preview {
	NoteView(note: Note(title: "foo", text: "bar", topic: Topic(title: "title")))
}
