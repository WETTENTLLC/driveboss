import SwiftUI

struct GasStation: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let address: String
    let distance: String
}

struct GasFinderView: View {
    @State private var location: String = ""
    @State private var stations: [GasStation] = [
        GasStation(name: "Shell", price: 3.59, address: "123 Main St", distance: "0.8 mi"),
        GasStation(name: "Chevron", price: 3.65, address: "456 Oak Ave", distance: "1.2 mi"),
        GasStation(name: "Costco", price: 3.49, address: "789 Market Rd", distance: "2.0 mi")
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Gas Finder")
                        .font(DriveBossTheme.Typography.title)
                        .foregroundColor(.primary)
                    HStack {
                        TextField("Enter location or use GPS", text: $location)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: findGas) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(hex: "7fffd4"))
                        }
                        .accessibilityLabel("Find Gas")
                    }
                    .padding(.bottom, 4)
                    ForEach(stations) { s in
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text(s.name)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("$\(s.price, specifier: "%.2f")/gal")
                                    .foregroundColor(Color(hex: "7ecbff"))
                            }
                            Text("\(s.address) • \(s.distance)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                        .overlay(Divider(), alignment: .bottom)
                    }
                }
                .driveBossCardStyle()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "eaf6ff"), Color(hex: "fffbe6")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                VStack(alignment: .leading, spacing: 8) {
                    Text("Map Preview")
                        .font(DriveBossTheme.Typography.title)
                        .foregroundColor(.primary)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "eaf6ff"))
                            .frame(height: 180)
                        Text("Map Preview (Google API)")
                            .foregroundColor(Color(hex: "7ecbff"))
                            .font(.title3)
                    }
                }
                .driveBossCardStyle()
            }
            .padding(DriveBossTheme.Layout.padding)
        }
        .background(DriveBossTheme.Colors.background)
    }
    func findGas() {
        // Placeholder: In future, call Google API
    }
}

struct GasFinderView_Previews: PreviewProvider {
    static var previews: some View {
        GasFinderView()
    }
}