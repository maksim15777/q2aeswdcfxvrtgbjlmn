// StarsPurchaseSuccessView.swift
// Celebration overlay shown after "buying" stars — mimics Telegram's success animation

import SwiftUI

struct StarsPurchaseSuccessView: View {

    let amount: Int64
    @State private var confetti: [ConfettiStar] = []
    @State private var checkScale: CGFloat = 0.1
    @State private var checkOpacity: Double = 0
    @State private var amountScale: CGFloat = 0.5
    @State private var amountOpacity: Double = 0

    private var formattedAmount: String {
        NumberFormatter.starsFormatter.string(from: NSNumber(value: amount)).map { "+\($0)" } ?? "+\(amount)"
    }

    var body: some View {
        ZStack {
            // Blur backdrop
            Color.black.opacity(0.55)
                .ignoresSafeArea()
                .allowsHitTesting(false)

            // Confetti
            GeometryReader { geo in
                ZStack {
                    ForEach(confetti) { star in
                        ConfettiStarView(particle: star, containerSize: geo.size)
                    }
                }
            }
            .ignoresSafeArea()

            // Success card
            VStack(spacing: 16) {
                // Big star with checkmark
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color(hue: 0.13, saturation: 0.5, brightness: 1).opacity(0.4), .clear],
                                center: .center, startRadius: 10, endRadius: 70
                            )
                        )
                        .frame(width: 130, height: 130)

                    Image(systemName: "star.fill")
                        .font(.system(size: 72))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color(hue: 0.14, saturation: 0.7, brightness: 1.0),
                                         Color(hue: 0.08, saturation: 1.0, brightness: 0.9)],
                                startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .shadow(color: Color(hue: 0.12, saturation: 1, brightness: 1).opacity(0.7),
                                radius: 20, x: 0, y: 0)

                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .background(Circle().fill(Color.green).padding(2))
                        .offset(x: 26, y: 26)
                }
                .scaleEffect(checkScale)
                .opacity(checkOpacity)

                // Amount
                Text(formattedAmount)
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(hue: 0.14, saturation: 0.7, brightness: 1.0),
                                     Color(hue: 0.08, saturation: 1.0, brightness: 0.9)],
                            startPoint: .leading, endPoint: .trailing)
                    )
                    .scaleEffect(amountScale)
                    .opacity(amountOpacity)

                Text("Звёзды добавлены!")
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .opacity(amountOpacity)

                Text("Баланс пополнен успешно")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .opacity(amountOpacity)
            }
            .padding(32)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .stroke(Color(hue: 0.13, saturation: 0.6, brightness: 0.9).opacity(0.5), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 40)
        }
        .onAppear {
            // Spawn confetti
            confetti = ConfettiStar.generate(count: 55)

            // Animate card
            withAnimation(.spring(response: 0.5, dampingFraction: 0.65).delay(0.05)) {
                checkScale = 1.0
                checkOpacity = 1.0
            }
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7).delay(0.2)) {
                amountScale = 1.0
                amountOpacity = 1.0
            }
        }
    }
}

// MARK: - Confetti

struct ConfettiStar: Identifiable {
    let id = UUID()
    let startX: CGFloat   // 0..1
    let delay: Double
    let duration: Double
    let size: CGFloat
    let hue: Double
    let rotation: Double

    static func generate(count: Int) -> [ConfettiStar] {
        (0..<count).map { _ in
            ConfettiStar(
                startX: CGFloat.random(in: 0.05...0.95),
                delay: Double.random(in: 0...0.8),
                duration: Double.random(in: 1.5...2.8),
                size: CGFloat.random(in: 8...22),
                hue: Double.random(in: 0.08...0.17),
                rotation: Double.random(in: 0...360)
            )
        }
    }
}

struct ConfettiStarView: View {

    let particle: ConfettiStar
    let containerSize: CGSize

    @State private var y: CGFloat = -30
    @State private var opacity: Double = 1
    @State private var rotation: Double = 0

    var body: some View {
        Image(systemName: "star.fill")
            .font(.system(size: particle.size))
            .foregroundColor(Color(hue: particle.hue, saturation: 0.9, brightness: 1))
            .opacity(opacity)
            .rotationEffect(.degrees(rotation))
            .position(x: particle.startX * containerSize.width, y: y)
            .onAppear {
                y = -20
                withAnimation(
                    .easeIn(duration: particle.duration).delay(particle.delay)
                ) {
                    y = containerSize.height + 40
                    rotation = particle.rotation + Double.random(in: 180...540)
                }
                withAnimation(
                    .easeIn(duration: 0.4).delay(particle.delay + particle.duration * 0.7)
                ) {
                    opacity = 0
                }
            }
    }
}

#Preview {
    StarsPurchaseSuccessView(amount: 1_000)
}
