//
//  Note.swift
//  Notes3
//
//  Created by Eric Kampman on 1/26/24.
//

import SwiftData
import Foundation

@Model 
class Topic {
	@Attribute(.unique) var title: String
	
	var notes = [Note]()
	
	init(title: String) {
		self.title = title
	}
}

@Model class NoteURL {
	let id = UUID()
	var url: String
	var info: String
	
	init(url: String, info: String) {
		self.url = url
		self.info = info
	}
}

@Model
final class Note {
	@Attribute(.unique) var title: String
	var text: String
	var topic: Topic
		
	init(title: String, text: String, topic: Topic) {
		self.title = title
		self.text = text
		self.topic = topic
	}
}
