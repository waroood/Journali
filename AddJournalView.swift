//
//  AddJournalView.swift
//  Journali
//
//  Created by warood on 30/05/1448 AH.
//
import SwiftUI

struct AddJournalView: View {

    @Environment(\.dismiss) private var dismiss

    var journal: JournalEntry?
    var onSave: (String, String) -> Void

    @State private var journalTitle: String
    @State private var journalText: String
    @State private var showDiscardAlert = false

    init(
        journal: JournalEntry? = nil,
        onSave: @escaping (String, String) -> Void
    ) {
        self.journal = journal
        self.onSave = onSave

        _journalTitle = State(
            initialValue: journal?.title ?? ""
        )

        _journalText = State(
            initialValue: journal?.content ?? ""
        )
    }

    private var hasChanges: Bool {
        journalTitle != (journal?.title ?? "") ||
        journalText != (journal?.content ?? "")
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 18) {

            // MARK: - Top Buttons
            HStack {

                Button {
                    if hasChanges {
                        showDiscardAlert = true
                    } else {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background(.white.opacity(0.12))
                        .clipShape(Circle())
                }

                Spacer()

                Button {
                    onSave(journalTitle, journalText)
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.title3.bold())
                        .foregroundStyle(.black)
                        .frame(width: 46, height: 46)
                        .background(
                            Color(
                                red: 0.72,
                                green: 0.75,
                                blue: 1
                            )
                        )
                        .clipShape(Circle())
                }
            }

            // MARK: - Journal Title
            TextField("Title", text: $journalTitle)
                .font(.system(size: 32, weight: .bold))
                .tint(.white)

            // MARK: - Date
            Text(journal?.date ?? Date(), style: .date)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))

            // MARK: - Journal Content
            TextEditor(text: $journalText)
                .font(.system(size: 18))
                .scrollContentBackground(.hidden)
                .overlay(alignment: .topLeading) {

                    if journalText.isEmpty {
                        Text("Type your Journal...")
                            .font(.system(size: 18))
                            .foregroundStyle(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                            .allowsHitTesting(false)
                    }
                }

            Spacer(minLength: 0)
        }
        .padding(24)
        .foregroundStyle(.white)
        .background(
            Color(red: 0.29, green: 0.29, blue: 0.33)
        )
        .preferredColorScheme(.dark)
        .interactiveDismissDisabled(hasChanges)

        // MARK: - Discard Confirmation
        .alert(
            "Discard Changes?",
            isPresented: $showDiscardAlert
        ) {
            Button(
                "Discard Changes",
                role: .destructive
            ) {
                dismiss()
            }

            Button("Keep Editing", role: .cancel) {}

        } message: {
            Text(
                "Are you sure you want to discard changes on this journal?"
            )
        }
    }
}

#Preview {
    AddJournalView { _, _ in }
}
