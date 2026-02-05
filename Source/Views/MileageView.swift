import SwiftUI

struct MileageView: View {
    @State private var showAdd = false
    @State private var trips: [MileageEntry] = [
        MileageEntry(miles: 32, date: Date().addingTimeInterval(-86400*4), notes: "Auto"),
        MileageEntry(miles: 18, date: Date().addingTimeInterval(-86400*2), notes: "Manual"),
        MileageEntry(miles: 22, date: Date().addingTimeInterval(-86400*1), notes: "Auto")
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Mileage")
                            .font(DriveBossTheme.Typography.title)
                            .foregroundColor(.primary)
                        Spacer()
                        Button(action: { showAdd = true }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color(hex: "ffe066"))
                                .font(.title2)
                        }
                        .accessibilityLabel("Add Mileage")
                    }
                    if trips.isEmpty {
                        Text("No trips recorded.")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(trips.sorted { $0.date > $1.date }) { trip in
                            HStack {
                                Text("\(trip.miles, specifier: "%.0f") mi")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                Text(trip.notes ?? "")
                                    .foregroundColor(Color(hex: "ffe066"))
                                Spacer()
                                Text(trip.date, style: .date)
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                            .padding(.vertical, 6)
                            .overlay(Divider(), alignment: .bottom)
                        }
                    }
                }
                .driveBossCardStyle()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "eafff2"), Color(hex: "eaf6ff")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                VStack(alignment: .leading, spacing: 8) {
                    Text("Mileage Chart")
                        .font(DriveBossTheme.Typography.title)
                        .foregroundColor(.primary)
                    MileageBarChart(trips: trips)
                }
                .driveBossCardStyle()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "fffbe6"), Color(hex: "eaf6ff")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            }
            .padding(DriveBossTheme.Layout.padding)
        }
        .sheet(isPresented: $showAdd) {
            AddMileageView { miles, notes in
                trips.append(MileageEntry(miles: miles, date: Date(), notes: notes))
            }
        }
        .background(DriveBossTheme.Colors.background)
    }
}

struct AddMileageView: View {
    @Environment(\.dismiss) var dismiss
    @State private var miles: String = ""
    @State private var notes: String = ""
    var onAdd: (Double, String) -> Void
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Miles")) {
                    TextField("Miles", text: $miles)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Notes")) {
                    TextField("Notes (optional)", text: $notes)
                }
            }
            .navigationTitle("Add Mileage")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if let m = Double(miles), m > 0 {
                            onAdd(m, notes)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

struct MileageBarChart: View {
    let trips: [MileageEntry]
    var body: some View {
        let days = (0..<7).map { Calendar.current.date(byAdding: .day, value: -6+$0, to: Date())! }
        let totals = days.map { day in
            trips.filter { Calendar.current.isDate($0.date, inSameDayAs: day) }.reduce(0) { $0 + $1.miles }
        }
        let maxVal = max(totals.max() ?? 40, 40)
        HStack(alignment: .bottom, spacing: 8) {
            ForEach(0..<7, id: \.self) { i in
                VStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "7ecbff"), Color(hex: "ffe066"), Color(hex: "7fffd4")] ), startPoint: .top, endPoint: .bottom))
                        .frame(height: CGFloat(totals[i]) / CGFloat(maxVal) * 60 + 8)
                    Text(shortDay(days[i]))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .frame(height: 80)
    }
    func shortDay(_ date: Date) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "E"
        return fmt.string(from: date)
    }
}

struct MileageEntry: Identifiable {
    let id = UUID()
    let miles: Double
    let date: Date
    let notes: String?
}

struct MileageView_Previews: PreviewProvider {
    static var previews: some View {
        MileageView()
    }
}