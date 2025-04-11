//
//  InfoView.swift
//  Task
//
//  Created by Maja Frąk on 11/04/2025.
//

import SwiftUI

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
        }
    }
}
