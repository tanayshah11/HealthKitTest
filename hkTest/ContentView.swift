//
//  ContentView.swift
//  hkTest
//
//  Created by Tanay Shah on 6/24/24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var sleepData: [String: TimeInterval] = ["Awake": 0, "Core": 0, "REM": 0, "Deep": 0]
    @State private var authorizationStatus: String = "Not authorized"

    var body: some View {
        VStack {
            Text("Sleep Analysis")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
                .foregroundColor(.white)
            ForEach(sleepData.sorted(by: >), id: \.key) { key, value in
                SleepAnalysisView(category: key, duration: value)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
            }
            Spacer()
            Text("Authorization Status: \(authorizationStatus)")
                .font(.footnote)
                .foregroundColor(.white)
                .padding()
            Button(action: requestHealthKitAuthorization) {
                Text("Authorize HealthKit")
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.bottom, 10)
            Button(action: querySleepAnalysis) {
                Text("Query Sleep Analysis")
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.bottom, 20)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            requestHealthKitAuthorization()
        }
    }

    func requestHealthKitAuthorization() {
        HealthKitManager.shared.requestHealthKitAuthorization { success, error in
            if success {
                authorizationStatus = "Authorized"
                print("HealthKit authorization granted.")
            } else {
                authorizationStatus = "Not authorized: \(String(describing: error?.localizedDescription))"
                print("HealthKit authorization failed: \(String(describing: error?.localizedDescription))")
            }
        }
    }

    func querySleepAnalysis() {
        HealthKitManager.shared.querySleepAnalysis { data, error in
            if let error = error {
                print("Failed to fetch sleep analysis: \(error.localizedDescription)")
            } else if let data = data {
                self.sleepData = data
                print("Fetched sleep analysis data: \(data)")
            }
        }
    }
}

#Preview {
    ContentView()
}
