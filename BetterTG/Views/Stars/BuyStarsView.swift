// BuyStarsView.swift
// Fake "Buy Stars" sheet — mirrors the Telegram purchase UI

import SwiftUI

struct StarPackage: Identifiable {
    let id = UUID()
    let amount: Int64
    let price: String
    let iconScale: Double  // larger = more star layers shown
}

private let packages: [StarPackage] = [
    StarPackage(amount: 100,    price: "2,39 $",   iconScale: 1.0),
    StarPackage(amount: 250,    price: "6,09 $",   iconScale: 1.1),
    StarPackage(amount: 500,    price: "11,99 $",  iconScale: 1.2),
    StarPackage(amount: 1_000,  price: "23,99 $",  iconScale: 1.3),
    StarPackage(amount: 1_500,  price: "36,49 $",  iconScale: 1.4),
    StarPackage(amount: 2_500,  price: "60,99 $",  iconScale: 1.5),
    StarPackage(amount: 5_000,  price: "119,00 $", iconScale: 1.6),
    StarPackage(amount: 10_000, price: "239,00 $", iconScale: 1.7),
    StarPackage(amount: 25_000, price: "609,00 $", iconScale: 1.8),
    StarPackage(amount: 35_000, price: "849,00 $", iconScale: 2.0),
]

struct BuyStarsView: View {

    @EnvironmentObject var starsVM: StarsViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var tappedId: UUID?

    private var formattedBalance: String {
        NumberFormatter.starsFormatter.string(from: NSNumber(value: starsVM.balance)) ?? "\(starsVM.balance)"
    }

    var body: some View {
        ZStack {
            // Dark background
            Color(white: 0.08).ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                ZStack {
                    Text("Купить звёзды")
                        .font(.headline)
                        .foregroundColor(.white)

                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Circle().fill(Color.white.opacity(0.15)))
                        }
                        Spacer()
                        // Balance
                        VStack(alignment: .trailing, spacing: 0) {
                            Text("Баланс")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            HStack(spacing: 3) {
                                Image(systemName: "star.fill")
                                    .font(.caption)
                                    .foregroundColor(.yellow)
                                Text(formattedBalance)
                                    .font(.caption.bold())
                                    .foregroundColor(.white)
                                    .contentTransition(.numericText())
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)

                Divider().background(Color.white.opacity(0.1))

                // Package list
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(packages) { pkg in
                            packageRow(pkg)
                        }
                    }
                    .padding(16)

                    Text("Приобретая звёзды, Вы принимаете условия Telegram.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                }
            }
        }
    }

    @ViewBuilder
    private func packageRow(_ pkg: StarPackage) -> some View {
        Button {
            tappedId = pkg.id
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {}
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                starsVM.purchase(pkg.amount)
                dismiss()
            }
        } label: {
            HStack(spacing: 14) {
                // Star icon (layered for visual weight)
                ZStack {
                    ForEach(0..<Int(pkg.iconScale * 2), id: \.self) { i in
                        Image(systemName: "star.fill")
                            .font(.system(size: 22 + CGFloat(i) * 2))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color(hue: 0.13, saturation: 0.7, brightness: 1),
                                             Color(hue: 0.08, saturation: 1, brightness: 0.9)],
                                    startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .opacity(i == Int(pkg.iconScale * 2) - 1 ? 1 : 0.3)
                            .rotationEffect(.degrees(Double(i) * 5))
                    }
                }
                .frame(width: 36, height: 36)

                // Amount
                Text(NumberFormatter.starsFormatter.string(from: NSNumber(value: pkg.amount)).map { "\($0) звёзд" } ?? "\(pkg.amount) звёзд")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)

                Spacer()

                // Price
                Text(pkg.price)
                    .font(.system(size: 15))
                    .foregroundColor(Color.white.opacity(0.5))
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color.white.opacity(tappedId == pkg.id ? 0.15 : 0.07))
            )
            .scaleEffect(tappedId == pkg.id ? 0.97 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: tappedId)
        }
        .buttonStyle(.plain)
    }
}



#Preview {
    BuyStarsView()
        .environmentObject(StarsViewModel())
}
