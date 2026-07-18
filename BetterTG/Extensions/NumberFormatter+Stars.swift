// NumberFormatter+Stars.swift
// Shared NumberFormatter extension for Stars balance formatting

import Foundation

extension NumberFormatter {
    static let starsFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.groupingSeparator = ","
        return f
    }()
}
