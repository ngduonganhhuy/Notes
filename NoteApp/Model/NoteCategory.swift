//
//  NoteCategory.swift
//  NoteApp
//
//  Created by Huy Nguyễn Dương Anh on 16/8/24.
//

import SwiftData

@Model
class NoteCategory {
    var categoryTitle: String
    //Relationship
    @Relationship( deleteRule: .cascade, inverse: \Note.category)
    var notes: [Note]?
    
    init(categoryTitle: String) {
        self.categoryTitle = categoryTitle
    }
}
