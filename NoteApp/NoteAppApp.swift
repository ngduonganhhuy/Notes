//
//  NoteAppApp.swift
//  NoteApp
//
//  Created by Huy Nguyễn Dương Anh on 16/8/24.
//

import SwiftUI
import SwiftData

@main
struct NoteAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 300, minHeight: 400)
        }
        .windowResizability(.contentSize)
        /// Adding Data Model to the App
        .modelContainer(for: [Note.self, NoteCategory.self])
    }
}
