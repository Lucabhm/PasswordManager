//
//  Unlocked.swift
//  Password Manager
//
//  Created by Luca Böhm on 15.06.25.
//

import Foundation
import SwiftUI

struct SetupView: View {
    @Environment(\.dismiss) var dismiss

    @State private var masterPassword = ""
    @State private var confirmPassword = ""
    @State private var tresorName = ""
    @State private var showMismatchError = false

    var passwordsMatch: Bool {
        !masterPassword.isEmpty &&
        masterPassword == confirmPassword
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Master-Passwort erstellen")) {
                    TextField("Name", text: $tresorName)
                    SecureField("Neues Passwort", text: $masterPassword)
                    SecureField("Bestätigen", text: $confirmPassword)

                    if showMismatchError && !passwordsMatch {
                        Text("Passwörter stimmen nicht überein.")
                            .foregroundColor(.red)
                    }
                }

                Section {
                    Button("Tresor anlegen") {
                        if passwordsMatch {
                            // Speichern oder Verschlüsselung einleiten
                            saveMasterPassword()
                            dismiss()
                        } else {
                            showMismatchError = true
                        }
                    }
                    .disabled(masterPassword.count < 6 || !passwordsMatch)
                }
            }
            .navigationTitle("Neuer Tresor")
        }
    }

    func saveMasterPassword() {
        // Hier später Key ableiten und in Keychain speichern
        print("Masterpasswort gespeichert: \(masterPassword)")
    }
}
