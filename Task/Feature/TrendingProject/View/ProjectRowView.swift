//
//  ProjectCardView.swift
//  Task
//
//  Created by Maja Frąk on 10/04/2025.
//

import SwiftUI

struct ProjectRowView: View {
    let project: ProjectModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(project.name)
                .font(.headline)
            ownerAndLanguageView
            separatorView
            detailsView
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: .tabViewHeight)
        .background(
            RoundedRectangle(cornerRadius: .sizeSmall)
                .fill(.row)
                .shadow(radius: .sizeXSmall)
        )
        .padding(.horizontal)
    }
    
    private var ownerAndLanguageView: some View {
        HStack {
            AsyncImage(url: URL(string: project.owner.avatarURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: .sizeLarge, height: .sizeLarge)
                        .clipShape(RoundedRectangle(cornerRadius: .cornerRadius))
                        .scaledToFit()
                case .failure, .empty:
                    Image(systemName: Icons.person)
                @unknown default:
                    Image(systemName: Icons.person)
                        .frame(width: .sizeLarge, height: .sizeLarge)
                }
            }
            Text(project.owner.login)
            Spacer()
            Text(project.language ?? "")
        }
    }
    
    private var separatorView: some View {
        Rectangle()
            .fill(project.archived ? LinearGradient(gradient: Gradient(colors: [Color.line, Color.gray]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [Color.line, Color.green]), startPoint: .leading, endPoint: .trailing))
            .frame(height: .lineHeight)
    }
    
    private var detailsView: some View {
        HStack {
            QuantityView(image: Icons.star, quantity: project.stargazersCount)
            Spacer()
            QuantityView(image: Icons.fork, quantity: project.forksCount)
            Spacer()
            QuantityView(image: Icons.hammer, quantity: project.openIssues)
        }
    }
}

private extension ProjectRowView {
    struct Icons {
        static let person = "person.crop.square.fill"
        static let star = "star.fill"
        static let fork = "tuningfork"
        static let hammer = "hammer.fill"
    }
}
