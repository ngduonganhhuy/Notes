//
//  Note.swift
//  NoteApp
//
//  Created by Huy Nguyễn Dương Anh on 16/8/24.
//

import SwiftData

@Model
class Note{
    var content: String
    var isFavourite: Bool = false
    var category: NoteCategory?
    
    init(content: String, category: NoteCategory? = nil) {
        self.content = content
        self.category = category
    }
}
