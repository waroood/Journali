
//
//  HomeView.swift
//  Journali
//
//  Created by warood on 30/05/1448 AH.
//

import SwiftUI
import SwiftData

enum JournalSortOption {
    case bookmark
    case entryDate
}

struct HomeView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var journals: [JournalEntry]

    @State private var searchText = ""
    @State private var showAddJournal = false
    @State private var editingJournal: JournalEntry?
    @State private var journalToDelete: UUID?
    @State private var showDeleteAlert = false
    @State private var swipedJournalID: UUID?
    @State private var sortOption: JournalSortOption = .entryDate

    private var filteredJournals: [JournalEntry] {
        let filtered = journals.filter {
            searchText.isEmpty ||
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.content.localizedCaseInsensitiveContains(searchText)
        }

        switch sortOption {
        case .bookmark:
            return filtered.sorted {
                if $0.isBookmarked != $1.isBookmarked {
                    return $0.isBookmarked && !$1.isBookmarked
                }
                return $0.date > $1.date
            }

        case .entryDate:
            return filtered.sorted { $0.date > $1.date }
        }
    }

    var body: some View {
        ZStack {
            JournaliColors.background.ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: - Header
                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(JournaliColors.primaryText)

                    Spacer()

                    HStack(spacing: 20) {
                        Menu {
                            Button("Sort by Bookmark") {
                                withAnimation {
                                    sortOption = .bookmark
                                    swipedJournalID = nil
                                }
                            }

                            Button("Sort by Entry Date") {
                                withAnimation {
                                    sortOption = .entryDate
                                    swipedJournalID = nil
                                }
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .font(.system(size: 20))
                        }

                        Button {
                            showAddJournal = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                        }
                    }
                    .foregroundStyle(JournaliColors.primaryText)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(JournaliColors.card)
                    .clipShape(Capsule())
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 16)

                // MARK: - Journal Content
                if journals.isEmpty {
                    Spacer()

                    VStack(spacing: 16) {
                        Image("EmptyJournal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)

                        Text("Begin Your Journal")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(JournaliColors.accentText)

                        Text("Craft your personal diary, tap the\nplus icon to begin")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundStyle(JournaliColors.primaryText)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal, 24)

                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            
                            
                            ForEach(filteredJournals) { journal in
                                ZStack(alignment: .trailing) {
                                    
                                    // Delete Button
                                    Button {
                                        journalToDelete = journal.id
                                        showDeleteAlert = true
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .font(.system(size: 22))
                                            .foregroundStyle(.white)
                                            .frame(width: 60, height: 60)
                                            .background(JournaliColors.destructive)
                                            .clipShape(Circle())
                                    }
                                    .padding(.trailing, 12)
                                    
                                    // Journal Card
                                    JournalCard(
                                        journal: journal,
                                        onBookmark: { toggleBookmark(journal.id) }
                                    )
                                    .contentShape(RoundedRectangle(cornerRadius: 28))
                                    .onTapGesture {
                                        if swipedJournalID == journal.id {
                                            withAnimation {
                                                swipedJournalID = nil
                                            }
                                        } else {
                                            editingJournal = journal
                                        }
                                    }
                                    .offset(x: swipedJournalID == journal.id ? -85 : 0)
                                    .gesture(
                                        DragGesture(minimumDistance: 25)
                                            .onEnded { value in
                                                withAnimation(.easeInOut) {
                                                    if value.translation.width < -50 {
                                                        swipedJournalID = journal.id
                                                    } else if value.translation.width > 50 {
                                                        swipedJournalID = nil
                                                    }
                                                }
                                            }
                                    )
                                }
                            }
                        }
                            .padding(.horizontal, 24)
                            .padding(.top, 14)
                            
                        }
                    }

                // MARK: - Search Bar
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")

                    TextField("Search", text: $searchText)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundStyle(JournaliColors.primaryText)
                        .tint(JournaliColors.primary)

                    Image(systemName: "mic.fill")
                }
                .foregroundStyle(JournaliColors.secondaryText)
                .padding(.horizontal, 16)
                .frame(height: 48)
                .background(JournaliColors.card)
                .clipShape(Capsule())
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
        }

        // .preferredColorScheme(.dark)

        // MARK: - Add Journal
        .sheet(isPresented: $showAddJournal) {
            AddJournalView { title, text in
                let newJournal = JournalEntry(
                    title: title.isEmpty ? "Untitled Journal" : title,
                    content: text,
                    date: Date()
                )
                modelContext.insert(newJournal)
                saveChanges()
            }
        }

        // MARK: - Edit Journal
        .sheet(item: $editingJournal) { journal in
            AddJournalView(journal: journal) { title, text in
                journal.title = title.isEmpty ? "Untitled Journal" : title
                journal.content = text
                saveChanges()
            }
        }

        // MARK: - Delete Confirmation
        .alert("Delete Journal?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {
                journalToDelete = nil
            }

            Button("Delete", role: .destructive) {
                if let id = journalToDelete,
                   let journal = journals.first(where: { $0.id == id }) {
                    modelContext.delete(journal)
                    saveChanges()
                }
                journalToDelete = nil
                swipedJournalID = nil
            }
        } message: {
            Text("Are you sure you want to delete this journal?")
        }
    }

    // MARK: - Bookmark
    private func toggleBookmark(_ id: UUID) {
        guard let journal = journals.first(where: { $0.id == id }) else {
            return
        }
        journal.isBookmarked.toggle()
        saveChanges()
    }

    // MARK: - Persist Changes
    private func saveChanges() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save journal changes: \(error)")
        }
    }
}

// MARK: - Journal Card
struct JournalCard: View {

    let journal: JournalEntry
    let onBookmark: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(journal.title)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(JournaliColors.accentText)

                    Text(journal.date, style: .date)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(JournaliColors.secondaryText)
                }

                Spacer()

                Button(action: onBookmark) {
                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 24))
                        .foregroundStyle(JournaliColors.accentText)
                }
                .buttonStyle(.plain)
            }

            Text(journal.content)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(JournaliColors.primaryText)
                .lineSpacing(3)
                .lineLimit(5)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(JournaliColors.card)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}

#Preview {
    HomeView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
