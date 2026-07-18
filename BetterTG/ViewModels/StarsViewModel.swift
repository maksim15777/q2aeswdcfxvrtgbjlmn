// StarsViewModel.swift
// Manages fake Telegram Stars balance with persistence

import SwiftUI
import Combine

final class StarsViewModel: ObservableObject {

    @Published var balance: Int64 {
        didSet {
            UserDefaults.standard.set(balance, forKey: "fake_stars_balance")
        }
    }

    @Published var showBuyStars = false
    @Published var showMainStars = false
    @Published var purchasedAmount: Int64 = 0
    @Published var showSuccessAnimation = false

    init() {
        self.balance = Int64(UserDefaults.standard.integer(forKey: "fake_stars_balance"))
    }

    func purchase(_ amount: Int64) {
        balance += amount
        purchasedAmount = amount
        showBuyStars = false
        showMainStars = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                self.showSuccessAnimation = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation(.easeOut(duration: 0.4)) {
                self.showSuccessAnimation = false
            }
        }
    }
}
