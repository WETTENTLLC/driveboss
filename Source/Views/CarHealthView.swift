import SwiftUI

struct MaintenanceLog: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
    let notes: String?
}

struct CarHealthView: View {
    @State private var healthScore: Int = 92
    @State private var reminders: [String] = ["Oil Change due in 2 weeks", "Tire Rotation in 1 month"]
    @State private var logs: [MaintenanceLog] = [
        MaintenanceLog(title: "Oil Change", date: Date().addingTimeInterval(-86400*30), notes: "Synthetic oil"),
        MaintenanceLog(title: "Tire Rotation", date: Date().addingTimeInterval(-86400*60), notes: nil)
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Car Health Score")
                        .font(DriveBossTheme.Typography.title)
                        .foregroundColor(.primary)
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .stroke(LinearGradient(gradient: Gradient(colors: [Color(hex: "7fffd4"), Color(hex: "7ecbff"), Color(hex: "ffe066")]), startPoint: .top, endPoint: .bottom), lineWidth: 8)
                                .frame(width: 72, height: 72)
                            Text("\(healthScore)")
                                .font(.largeTitle).fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                        VStack(alignment: .leading) {
                            Text("Excellent")
                                .font(.title3).fontWeight(.semibold)
                                .foregroundColor(Color(hex: "7fffd4"))
                            Text("Keep up with maintenance for best performance.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .driveBossCardStyle()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "eafff2"), Color(hex: "eaf6ff")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                VStack(alignment: .leading, spacing: 8) {
                    Text("Maintenance Reminders")
                        .font(DriveBossTheme.Typography.title)
                        .foregroundColor(.primary)
                    ForEach(reminders, id: \.self) { r in
                        HStack {
                            Image(systemName: "bell")
                                .foregroundColor(Color(hex: "ffe066"))
                            Text(r)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .driveBossCardStyle()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "fffbe6"), Color(hex: "eaf6ff")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                VStack(alignment: .leading, spacing: 8) {
                    Text("Maintenance Log")
                        .font(DriveBossTheme.Typography.title)
                        .foregroundColor(.primary)
                    ForEach(logs.sorted { $0.date > $1.date }) { log in
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text(log.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text(log.date, style: .date)
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                            if let notes = log.notes, !notes.isEmpty {
                                Text(notes)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 6)
                        .overlay(Divider(), alignment: .bottom)
                    }
                }
                .driveBossCardStyle()
            }
            .padding(DriveBossTheme.Layout.padding)
        }
        .background(DriveBossTheme.Colors.background)
    }
}

struct CarHealthView_Previews: PreviewProvider {
    static var previews: some View {
        CarHealthView()
    }
}