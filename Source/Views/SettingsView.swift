import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var privacyMode = false
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(Color(hex: "7ecbff"))
                        VStack(alignment: .leading) {
                            Text("Alex Driver")
                                .font(.headline)
                            Text("alex@email.com")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                Section(header: Text("Car Info")) {
                    HStack {
                        Image(systemName: "car.fill")
                            .foregroundColor(Color(hex: "7fffd4"))
                        Text("2022 Toyota Camry")
                    }
                    HStack {
                        Image(systemName: "number")
                            .foregroundColor(Color(hex: "ffe066"))
                        Text("License: 123-XYZ")
                    }
                }
                Section(header: Text("Notifications")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Label("Enable Notifications", systemImage: "bell")
                    }
                }
                Section(header: Text("Privacy")) {
                    Toggle(isOn: $privacyMode) {
                        Label("Privacy Mode", systemImage: "lock.shield")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}