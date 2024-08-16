//
//  Item.swift
//  NoteApp
//
//  Created by Huy Nguyễn Dương Anh on 16/8/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
