//
//  NotesSampleData.swift
//  Notes3
//
//  Created by Eric Kampman on 1/26/24.
//

import Foundation
import SwiftData

//extension Note {
//	static let faucet = Note(title: "Faucet", text: "Check if on")
//	static let trash = Note(title: "Trash", text: "Goes out Sunday evening")
//	static let reformat = Note(title: "Reformat", text: "Ctl-I")
//	static let mode = Note(title: "Mode", text: "Need to look this up")
//}


extension Topic {
	static let general = Topic(title: "General")
	static let xcode = Topic(title: "Xcode")

	static func insertSampleData(modelContext: ModelContext) {
		modelContext.insert(general)
		modelContext.insert(xcode)

//		modelContext.insert(Note.faucet)
//		modelContext.insert(Note.trash)
//		modelContext.insert(Note.reformat)
//		modelContext.insert(Note.mode)
//		
//		Note.faucet.topic =

	}
		
}
