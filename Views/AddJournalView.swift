
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
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(JournaliColors.primaryText)
                        .frame(width: 42, height: 42)
                        .background(JournaliColors.buttonBackground)
                        .clipShape(Circle())
                }

                Spacer()

                Button {
                    onSave(journalTitle, journalText)
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(JournaliColors.saveButtonText)
                        .frame(width: 46, height: 46)
                        .background(JournaliColors.primary)
                        .clipShape(Circle())
                }
            }
            .buttonStyle(.plain)
            .padding(.bottom, 12)

            // MARK: - Journal Title
            TextField("Title", text: $journalTitle)
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(JournaliColors.primaryText)
                .tint(JournaliColors.primary)
                .textInputAutocapitalization(.sentences)

            // MARK: - Date
            Text(journal?.date ?? Date(), style: .date)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(JournaliColors.secondaryText)

            // MARK: - Journal Content
            TextEditor(text: $journalText)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(JournaliColors.primaryText)
                .tint(JournaliColors.primary)
                .scrollContentBackground(.hidden)
                .background(JournaliColors.editorBackground)
                .overlay(alignment: .topLeading) {
                    if journalText.isEmpty {
                        Text("Type your Journal...")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundStyle(JournaliColors.placeholderText)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                            .allowsHitTesting(false)
                    }
                }

            Spacer(minLength: 0)
        }
        .padding(24)
        .foregroundStyle(JournaliColors.primaryText)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(JournaliColors.editorBackground.ignoresSafeArea())

        // .preferredColorScheme(.dark)

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
