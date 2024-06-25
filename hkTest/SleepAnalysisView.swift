//
//  SleepAnalysisView.swift
//  hkTest
//
//  Created by Tanay Shah on 6/24/24.
//

import SwiftUI

struct SleepAnalysisView: View {
    var category: String
    var duration: TimeInterval

    var body: some View {
        HStack {
            Text(category)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Text(timeIntervalToString(duration))
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
        .shadow(radius: 5)
    }

    func timeIntervalToString(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = Int(interval) % 3600 / 60
        return "\(hours)h \(minutes)m"
    }
}

