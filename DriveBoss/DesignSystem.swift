import SwiftUI

enum DriveBossTheme {
    // MARK: - Colors
    enum Colors {
        static let background = Color(UIColor.systemBackground)
        static let highWhite = Color.white
        static let iTunesGray = Color(red: 0.96, green: 0.96, blue: 0.97)
        static let accentRed = Color(hex: "FA243C")
        static let accentBlue = Color(hex: "007AFF")
        static let primaryText = Color.primary
        static let secondaryText = Color.secondary
        static let separator = Color(UIColor.separator).opacity(0.5)
    }
    // MARK: - Corner radii
    enum Layout {
        static let cardCorner: CGFloat = 10
        static let buttonCorner: CGFloat = 8
        static let hairline: CGFloat = 0.5
        static let padding: CGFloat = 16
    }
    // MARK: - Typography
    enum Typography {
        static let header = Font.system(.largeTitle, design: .rounded).weight(.bold)
        static let title = Font.system(.title2, design: .rounded).weight(.semibold)
        static let body = Font.system(.body, design: .rounded)
        static let caption = Font.system(.caption, design: .rounded)
    }
}
// MARK: - View Modifiers
extension View {
    func driveBossCardStyle() -> some View {
        self.padding(DriveBossTheme.Layout.padding / 2)
            .background(DriveBossTheme.Colors.iTunesGray)
            .cornerRadius(DriveBossTheme.Layout.cardCorner)
            .overlay(
                RoundedRectangle(cornerRadius: DriveBossTheme.Layout.cardCorner)
                    .stroke(DriveBossTheme.Colors.separator, lineWidth: DriveBossTheme.Layout.hairline)
            )
    }
}
// MARK: - Color hex helper
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
