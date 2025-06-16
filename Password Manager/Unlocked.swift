//
//  Locked.swift
//  Password Manager
//
//  Created by Luca Böhm on 15.06.25.
//

import Foundation
import SwiftUI

struct PasswordDetailView: View {
    var entry: PasswordEntry

    var body: some View {
        Form {
            Section(header: Text("Anmeldedaten")) {
                Text("Benutzername: \(entry.username)")
                Text("Passwort: \(entry.password)")
                Text("URL: \(entry.url)")
            }

            Section {
                Button("Passwort kopieren") {
                    UIPasteboard.general.string = entry.password
                }
            }
        }
        .navigationTitle(entry.title)
    }
}

struct AddPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var passwordEntries: [PasswordEntry]

    @State private var title = ""
    @State private var username = ""
    @State private var password = ""
    @State private var url = ""

    var body: some View {
        Form {
            Section(header: Text("Details")) {
                TextField("Titel", text: $title)
                TextField("Benutzername", text: $username)
                SecureField("Passwort", text: $password)
                TextField("URL", text: $url)
            }

            Button("Speichern") {
                let newEntry = PasswordEntry(title: title, username: username, password: password, url: url)
                passwordEntries.append(newEntry)
                dismiss()
            }
            .disabled(title.isEmpty || username.isEmpty || password.isEmpty)
        }
        .navigationTitle("Neuer Eintrag")
    }
}

struct UnlockView: View {
    @State private var searchText = ""
    @State private var passwordEntries: [PasswordEntry] = [
        PasswordEntry(title: "Gmail", username: "luca@gmail.com", password: "••••••••", url: "https://mail.google.com"),
        PasswordEntry(title: "Netflix", username: "lucastream", password: "••••••••", url: "https://netflix.com")
    ]

    var filteredEntries: [PasswordEntry] {
        if searchText.isEmpty {
            return passwordEntries
        } else {
            return passwordEntries.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.username.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if passwordEntries.isEmpty {
                    Spacer()
                    Text("Noch keine Passwörter gespeichert.")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List(filteredEntries) { entry in
                        NavigationLink(destination: PasswordDetailView(entry: entry)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.title)
                                    .font(.headline)
                                Text(entry.username)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .searchable(text: $searchText, prompt: "Suchen...")
                }
            }
            .navigationTitle("PassVault")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddPasswordView(passwordEntries: $passwordEntries)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
