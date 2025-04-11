//
//  DateView.swift
//  Task
//
//  Created by Maja Frąk on 11/04/2025.
//

import SwiftUI

struct DateView: View {
    let title: String
    let date: Date?

    var body: some View {
        if let date = date {
            InfoRow(label: title, value: date.formatted(date: .abbreviated, time: .omitted))
        }
    }
}
