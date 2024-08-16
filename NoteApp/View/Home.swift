import SwiftData
import SwiftUI

struct Home: View {
    @State private var selectedTag: String? = "All Notes"
    @Query(animation: .snappy) private var categories: [NoteCategory]
    @Environment(\.modelContext) private var context
    @State private var addCategory: Bool = false
    @State private var categoryTitle: String = ""
    @State private var requestedCategory: NoteCategory?
    @State private var deleteRequest: Bool = false
    @State private var renameRequest: Bool = false
    @State private var isDark: Bool = true

    var body: some View {
        NavigationSplitView {
            categoryListView
        } detail: {
            NotesView(category: selectedTag, allCategories: categories)
        }
        .navigationTitle(selectedTag ?? "Notes")
        .toolbar {
            primaryActionToolBar
        }
        .preferredColorScheme(isDark ? .dark : .light)
        .alert("Add Category", isPresented: $addCategory) {
            TextField("Work", text: $categoryTitle)
            Button("Cancel", role: .cancel) {
                categoryTitle = ""
            }
            Button("Add") {
                let category = NoteCategory(categoryTitle: categoryTitle)
                context.insert(category)
                categoryTitle = ""
            }
        }
        .alert("Rename Category", isPresented: $renameRequest) {
            TextField("Work", text: $categoryTitle)
            Button("Cancel", role: .cancel) {
                categoryTitle = ""
                requestedCategory = nil
            }
            Button("Rename") {
                if let requestedCategory {
                    requestedCategory.categoryTitle = categoryTitle
                    categoryTitle = ""
                    self.requestedCategory = nil
                }
            }
        }
        .alert("Are you sure to delete \(categoryTitle) category?", isPresented: $deleteRequest) {
            Button("Cancel", role: .cancel) {
                categoryTitle = ""
                requestedCategory = nil
            }
            Button("Delete", role: .destructive) {
                if let requestedCategory {
                    context.delete(requestedCategory)
                    categoryTitle = ""
                    self.requestedCategory = nil
                }
            }
        }
    }

    // MARK: - Subviews

    private var categoryListView: some View {
        List(selection: $selectedTag) {
            Text("All Notes")
                .tag("All Notes")
                .foregroundStyle(selectedTag == "All Notes" ? Color.primary : .gray)

            Text("Favourites")
                .tag("Favourites")
                .foregroundStyle(selectedTag == "Favourites" ? Color.primary : .gray)

            userCreatedCategoriesSection
        }
    }

    private var userCreatedCategoriesSection: some View {
        Section {
            ForEach(categories) { category in
                Text(category.categoryTitle)
                    .tag(category.categoryTitle)
                    .foregroundStyle(selectedTag == category.categoryTitle ? Color.primary : .gray)
                    .contextMenu {
                        renameButton(for: category)
                        deleteButton(for: category)
                    }
            }
        } header: {
            HStack(spacing: 10) {
                Text("Categories")
                Button("", systemImage: "plus") {
                    addCategory = true
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func renameButton(for category: NoteCategory) -> some View {
        Button("Rename") {
            categoryTitle = category.categoryTitle
            requestedCategory = category
            renameRequest = true
        }
    }

    private func deleteButton(for category: NoteCategory) -> some View {
        Button("Delete") {
            categoryTitle = category.categoryTitle
            requestedCategory = category
            deleteRequest = true
        }
    }

    private var primaryActionToolBar: some View {
        HStack(spacing: 10) {
            Button("", systemImage: "plus") {
                let note = Note(content: "")
                context.insert(note)
                // Handle note creation
            }

            Button("", systemImage: isDark ? "sun.min" : "moon") {
                isDark.toggle()
            }
            .contentTransition(.symbolEffect(.replace))
        }
    }
}
