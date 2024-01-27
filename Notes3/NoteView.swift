//
//  NoteView.swift
//  Notes3
//
//  Created by Eric Kampman on 1/27/24.
//

import SwiftUI

struct NoteView: View {
	var noteTitle: String?
	@Environment(NavigationContext.self) private var navigationContext
	@Environment(\.modelContext) private var modelContext

    var body: some View {
		Text(noteTitle ?? "")
    }
}

#Preview {
	NoteView(noteTitle: "foo")
}
