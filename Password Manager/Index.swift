import Foundation
import SwiftUI

struct StartPageView: View {
    // Beispiel-Accounts, später aus deinem Secure Storage laden
    @State private var accounts: [String] = ["personal@example.com", "work@example.com"]
    @State private var selectedAccount: String = "personal@example.com"
    
    @State private var showUnlock = false
    @State private var showSetup = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()
                
                Image(systemName: "lock.shield.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)

                Text("Willkommen bei Lucrypt")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                // Account-Auswahl
                VStack(alignment: .leading, spacing: 8) {
                    Text("Wähle einen Account:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Picker("Account", selection: $selectedAccount) {
                        ForEach(accounts, id: \ .self) { account in
                            Text(account).tag(account)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 16) {
                    Button(action: {
                        showUnlock = true
                    }) {
                        Text("App entsperren als \(selectedAccount)")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    Button(action: {
                        showSetup = true
                    }) {
                        Text("Tresor einrichten")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $showUnlock) {
                // Übergib den ausgewählten Account an UnlockView
                UnlockView()
            }
            .navigationDestination(isPresented: $showSetup) {
                SetupView()
            }
        }
    }
}

#Preview {
    StartPageView()
}
