// TelegramStarsView.swift
// Main "Telegram Stars" intro screen — mirrors the original Telegram UI

import SwiftUI

struct TelegramStarsView: View {

    @EnvironmentObject var starsVM: StarsViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var starScale: CGFloat = 0.7
    @State private var starOpacity: Double = 0

    private var formattedBalance: String {
        NumberFormatter.starsFormatter.string(from: NSNumber(value: starsVM.balance)) ?? "\(starsVM.balance)"
    }

    var body: some View {
        ZStack {
            // Background — dark with golden sparkles
            Color.black.ignoresSafeArea()
            SparklesBackground()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {

                    // Back button
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Circle().fill(Color.white.opacity(0.15)))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                    // Big star
                    ZStack {
                        Image(systemName: "star.fill")
                            .font(.system(size: 90))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color(hue: 0.14, saturation: 0.7, brightness: 1.0),
                                             Color(hue: 0.08, saturation: 1.0, brightness: 0.9)],
                                    startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .shadow(color: Color(hue: 0.12, saturation: 1, brightness: 1).opacity(0.6),
                                    radius: 24, x: 0, y: 4)
                            .blur(radius: 0)

                        Image(systemName: "star.fill")
                            .font(.system(size: 90))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color(hue: 0.14, saturation: 0.7, brightness: 1.0),
                                             Color(hue: 0.08, saturation: 1.0, brightness: 0.9)],
                                    startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .shadow(color: Color(hue: 0.12, saturation: 1, brightness: 1).opacity(0.5),
                                    radius: 40, x: 0, y: 0)
                    }
                    .scaleEffect(starScale)
                    .opacity(starOpacity)
                    .padding(.top, 20)
                    .onAppear {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.65)) {
                            starScale = 1.0
                            starOpacity = 1.0
                        }
                    }

                    // Title
                    Text("Звёзды Telegram")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    Text("Звёзды Telegram нужны для оплаты\nконтента и услуг в мини-приложениях.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                        .padding(.horizontal, 32)

                    // Balance card
                    VStack(spacing: 12) {
                        HStack(spacing: 10) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.yellow)
                            Text(formattedBalance)
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.white)
                                .contentTransition(.numericText())
                                .animation(.spring(), value: starsVM.balance)
                        }
                        Text("Ваш баланс")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        // Action buttons
                        HStack(spacing: 10) {
                            Button {
                                starsVM.showBuyStars = true
                            } label: {
                                Label("Пополнить", systemImage: "plus.circle.fill")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.12)))
                            }
                            Button {
                                // Statistics (no-op for fake)
                            } label: {
                                Label("Статистика", systemImage: "chart.bar.fill")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.12)))
                            }
                        }

                        // Gift button
                        Button {
                            // Gift (no-op for fake)
                        } label: {
                            HStack {
                                Image(systemName: "person.2.fill")
                                    .foregroundColor(.secondary)
                                Text("Подарить звёзды друзьям")
                                    .font(.system(size: 15))
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.top, 2)
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.white.opacity(0.07))
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 24)

                    // Earn stars card
                    HStack(spacing: 14) {
                        Image(systemName: "star.circle.fill")
                            .font(.system(size: 36))
                            .foregroundStyle(
                                LinearGradient(colors: [.green, .mint], startPoint: .top, endPoint: .bottom)
                            )
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Заработать звёзды")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                            Text("Вы можете делиться ссылками на мини-приложения и получать часть их дохода в звёздах.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.white.opacity(0.07))
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 32)
                }
            }
        }
        .sheet(isPresented: $starsVM.showBuyStars) {
            BuyStarsView()
                .environmentObject(starsVM)
        }
    }
}

// MARK: - Sparkles background

struct SparklesBackground: View {

    @State private var particles: [SparkleParticle] = SparkleParticle.generate(count: 35)

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(particles) { p in
                    Image(systemName: "star.fill")
                        .font(.system(size: p.size))
                        .foregroundColor(Color(hue: p.hue, saturation: 0.8, brightness: 0.9))
                        .opacity(p.opacity)
                        .position(x: p.x * geo.size.width, y: p.y * geo.size.height)
                        .blur(radius: p.blur)
                }
            }
        }
    }
}

struct SparkleParticle: Identifiable {
    let id = UUID()
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let opacity: Double
    let blur: CGFloat
    let hue: Double

    static func generate(count: Int) -> [SparkleParticle] {
        (0..<count).map { _ in
            SparkleParticle(
                x: CGFloat.random(in: 0...1),
                y: CGFloat.random(in: 0...1),
                size: CGFloat.random(in: 6...18),
                opacity: Double.random(in: 0.15...0.6),
                blur: CGFloat.random(in: 0...2),
                hue: Double.random(in: 0.08...0.16)
            )
        }
    }
}

#Preview {
    TelegramStarsView()
        .environmentObject(StarsViewModel())
}
