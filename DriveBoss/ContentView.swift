import SwiftUI

struct ContentView: View {
    @StateObject private var vm = MainViewModel()

    var body: some View {
        TabView {
            NavigationStack {
                DashboardView()
                    .navigationTitle("DriveBoss")
                    .navigationBarTitleDisplayMode(.large)
            }
            .tabItem {
                Label("Dashboard", systemImage: "house")
            }

            NavigationStack {
                Text("Earnings")
            }
            .tabItem {
                Label("Earnings", systemImage: "dollarsign.circle")
            }

            NavigationStack {
                Text("Mileage")
            }
            .tabItem {
                Label("Mileage", systemImage: "car")
            }

            NavigationStack {
                Text("Settings")
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
        .accentColor(DriveBossTheme.Colors.accentRed)
    }
}

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Earnings")
                        .font(DriveBossTheme.Typography.title)
                        .foregroundColor(DriveBossTheme.Colors.primaryText)
                    Text("This week: $120")
                        .font(DriveBossTheme.Typography.body)
                        .foregroundColor(DriveBossTheme.Colors.secondaryText)
                }
                .driveBossCardStyle()

                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Mileage")
                            .font(DriveBossTheme.Typography.title)
                        Text("72 miles")
                            .font(DriveBossTheme.Typography.body)
                    }
                    .driveBossCardStyle()

                    VStack(alignment: .leading) {
                        Text("Car Health")
                            .font(DriveBossTheme.Typography.title)
                        Text("Good")
                            .font(DriveBossTheme.Typography.body)
                    }
                    .driveBossCardStyle()
                }
            }
            .padding(DriveBossTheme.Layout.padding)
        }
        .background(DriveBossTheme.Colors.background)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
