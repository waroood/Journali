# 📓 Journali
### Your thoughts, your story.

**Journali** is a personal journaling iOS application designed to help users capture their thoughts, document memories, and organize their daily experiences in one simple, intuitive space.

Built using **SwiftUI** and **SwiftData**, Journali provides a clean, user-friendly interface that automatically adapts to Light and Dark Mode.

## ✨ Main Features

- **Create Journals:** Write and save personal journal entries with a title, date, and content.
- **View Journals:** Browse previously saved entries in an organized journal list.
- **Edit Journals:** Update existing entries whenever needed.
- **Delete Journals:** Remove unwanted entries with a confirmation alert.
- **Bookmark Favorites:** Mark important entries for easy access.
- **Search Journals:** Quickly find entries by searching their titles or content.
- **Sort Journals:** Organize entries by date or bookmarked status.
- **Data Persistence:** Save journal entries locally using SwiftData.
- **Adaptive Appearance:** Automatically switch between Light and Dark Mode based on the device's system settings.

## 📱 App Screenshots

### 🌙 Dark Mode

<img width="399" height="806" alt="Screenshot 1448-06-07 at 9 21 13 AM" src="https://github.com/user-attachments/assets/c7115a7b-360d-48ee-b215-79453fc09abd" />
<img width="401" height="804" alt="Screenshot 1448-06-07 at 9 21 04 AM" src="https://github.com/user-attachments/assets/5f1e6718-d56b-497d-8777-6757a84970b3" />
<img width="393" height="814" alt="Screenshot 1448-06-07 at 9 20 53 AM" src="https://github.com/user-attachments/assets/c775c109-3629-4d7d-a7a0-1098f15e8dff" />

### ☀️ Light Mode
<img width="343" height="703" alt="Screenshot 1448-06-07 at 9 22 53 AM" src="https://github.com/user-attachments/assets/ec6aa0e1-beb2-458f-84db-3697455dc986" />
<img width="339" height="706" alt="Screenshot 1448-06-07 at 9 22 47 AM" src="https://github.com/user-attachments/assets/93809f66-ce59-4ab8-9881-5442317fd132" />
<img width="406" height="769" alt="Screenshot 1448-06-07 at 9 23 17 AM" src="https://github.com/user-attachments/assets/a1143c79-ff19-4772-a5b8-f0e27a67e751" />


## 🛠 Technologies Used

- **Swift:** Programming language.
- **SwiftUI:** Building the user interface.
- **SwiftData:** Local data storage and persistence.
- **MVVM Architecture:** Separating the Model, View, and ViewModel for better code organization.
- **Observation Framework:** Managing observable ViewModel state.
- **Xcode:** Development environment.
- **Sketch:** UI/UX design.

## 🏗 Architecture

Journali follows the **Model–View–ViewModel (MVVM)** architectural pattern.

- **Model:** `JournalEntry.swift` defines the journal data structure using SwiftData.
- **View:** SwiftUI screens display journal entries and handle user interactions.
- **ViewModel:** `JournalViewModel.swift` manages searching, sorting, and journal operations.

This separation helps keep the code organized, maintainable, and easier to understand.

## 🎯 Project Purpose

Journali was developed as part of a coding challenge at the **Apple Developer Academy**.

The project focuses on applying Swift programming concepts, building interfaces with SwiftUI, implementing local data persistence, and organizing application logic using MVVM architecture.

## 💜 Made with SwiftUI

*Every thought deserves a place to be remembered.*
