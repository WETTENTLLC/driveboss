import SwiftUI

struct EarningsView: View {
    @State private var showAdd = false
    @State private var earnings: [Earning] = [
        Earning(amount: 120, date: Date().addingTimeInterval(-86400*4), notes: "Uber"),
        Earning(amount: 85, date: Date().addingTimeInterval(-86400*2), notes: "Lyft"),
        Earning(amount: 60, date: Date().addingTimeInterval(-86400*1), notes: "DoorDash")
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Earnings")
                            .font(DriveBossTheme.Typography.title)
                            .foregroundColor(.primary)
                        Spacer()
                        Button(action: { showAdd = true }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color(hex: "7ecbff"))
                                .font(.title2)
                        }
                        .accessibilityLabel("Add Earning")
                    }
                    if earnings.isEmpty {
                        Text("No earnings yet.")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(earnings.sorted { $0.date > $1.date }) { earning in
                            HStack {
                                Text("$\(earning.amount, specifier: "%.2f")")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                Text(earning.notes ?? "")
                                    .foregroundColor(Color(hex: "7ecbff"))
                                Spacer()
                                Text(earning.date, style: .date)
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
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "fffbe6"), Color(hex: "eaf6ff")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                VStack(alignment: .leading, spacing: 8) {
                    Text("Earnings Chart")
                        .font(DriveBossTheme.Typography.title)
                        .foregroundColor(.primary)
                    EarningsBarChart(earnings: earnings)
                }
                .driveBossCardStyle()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "eafff2"), Color(hex: "eaf6ff")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            }
            .padding(DriveBossTheme.Layout.padding)
        }
        .sheet(isPresented: $showAdd) {
            AddEarningView { amount, notes in
                earnings.append(Earning(amount: amount, date: Date(), notes: notes))
            }
        }
        .background(DriveBossTheme.Colors.background)
    }
}

struct AddEarningView: View {
    @Environment(\.dismiss) var dismiss
    @State private var amount: String = ""
    @State private var notes: String = ""
    var onAdd: (Double, String) -> Void
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Amount")) {
                    TextField("Amount ($)", text: $amount)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Notes")) {
                    TextField("Notes (optional)", text: $notes)
                }
            }
            .navigationTitle("Add Earning")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if let amt = Double(amount), amt > 0 {
                            onAdd(amt, notes)
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

struct EarningsBarChart: View {
    let earnings: [Earning]
    var body: some View {
        let days = (0..<7).map { Calendar.current.date(byAdding: .day, value: -6+$0, to: Date())! }
        let totals = days.map { day in
            earnings.filter { Calendar.current.isDate($0.date, inSameDayAs: day) }.reduce(0) { $0 + $1.amount }
        }
        let maxVal = max(totals.max() ?? 100, 100)
        HStack(alignment: .bottom, spacing: 8) {
            ForEach(0..<7, id: \.self) { i in
                VStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "ffe066"), Color(hex: "7fffd4"), Color(hex: "7ecbff")] ), startPoint: .top, endPoint: .bottom))
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

struct EarningsView_Previews: PreviewProvider {
    static var previews: some View {
        EarningsView()
    }
}