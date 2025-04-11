//
//  QuantityView.swift
//  Task
//
//  Created by Maja Frąk on 11/04/2025.
//

import SwiftUI

struct QuantityView: View {
    
    let image: String
    let quantity: Int
    
    init(image: String, quantity: Int?) {
        self.image = image
        self.quantity = quantity ?? 0
    }
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .fill(.primary)
                    .frame(width: .sizeMedium, height: .sizeMedium)
                
                Image(systemName: image)
                    .foregroundColor(Color.contrast)
                    .font(.caption2)
            }
            Text("\(quantity)")
        }
        .font(.subheadline)
    }
}
