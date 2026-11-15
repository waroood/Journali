//
//  JournalEntry.swift
//  Journali
//
//  Created by warood on 30/05/1448 AH.
//

import Foundation
import SwiftData

@Model
final class JournalEntry {
    @Attribute(.unique) var id: UUID
    var title: String
    var content: String
    var date: Date
    var isBookmarked: Bool

    init(title: String, content: String, date: Date = Date(), isBookmarked: Bool = false) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.date = date
        self.isBookmarked = isBookmarked
    }
}

