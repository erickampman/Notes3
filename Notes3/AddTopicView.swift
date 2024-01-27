//
//  AddTopicView.swift
//  Notes3
//
//  Created by Eric Kampman on 1/27/24.
//

import SwiftUI

struct AddTopicView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext

	@State private var title = ""

    var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Topic Title", text: $title)
						.frame(minWidth: 200)
						.padding()
				}
			}
			.toolbar {
				ToolbarItem(placement: .principal) {
					Text("Add Topic")
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button("Save") {
						withAnimation {
							let topic = Topic(title: title)
							modelContext.insert(topic)
							dismiss()
						}
					}
					.disabled(title.isEmpty)
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
    AddTopicView()
}
