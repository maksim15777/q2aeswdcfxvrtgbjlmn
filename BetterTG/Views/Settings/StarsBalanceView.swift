// StarsBalanceView.swift
// Fake Telegram Stars balance widget for BetterTG

import SwiftUI

struct StarsBalanceView: View {

    let balance: Int64

    private var formattedBalance: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: balance)) ?? "\(balance)"
    }

    var body: some View {
        VStack(spacing: 0) {
            // Star icon with glow
            ZStack {
                // Outer glow
                Image(systemName: "star.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(hue: 0.13, saturation: 1, brightness: 1),
                                     Color(hue: 0.09, saturation: 1, brightness: 1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .blur(radius: 14)
                    .opacity(0.7)

                // Main star
                Image(systemName: "star.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(hue: 0.14, saturation: 0.85, brightness: 1.0),
                                Color(hue: 0.09, saturation: 1.0, brightness: 0.95)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .shadow(color: Color(hue: 0.12, saturation: 1, brightness: 1).opacity(0.8),
                            radius: 8, x: 0, y: 2)
            }
            .padding(.top, 20)

            // Balance number
            Text(formattedBalance)
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(hue: 0.14, saturation: 0.8, brightness: 1.0),
                            Color(hue: 0.09, saturation: 1.0, brightness: 0.9)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .padding(.top, 10)
                .contentTransition(.numericText())

            Text("Stars Balance")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.top, 4)

            // Action buttons
            HStack(spacing: 12) {
                starsButton(title: "Send", icon: "paperplane.fill")
                starsButton(title: "Top Up", icon: "plus.circle.fill")
                starsButton(title: "History", icon: "clock.fill")
            }
            .padding(.top, 18)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color(hue: 0.14, saturation: 0.6, brightness: 1).opacity(0.6),
                                    Color.clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
    }

    @ViewBuilder
    private func starsButton(title: String, icon: String) -> some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(hue: 0.14, saturation: 0.7, brightness: 1.0),
                                Color(hue: 0.09, saturation: 1.0, brightness: 0.9)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 48, height: 48)
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    StarsBalanceView(balance: 999_999_999)
        .padding()
}
