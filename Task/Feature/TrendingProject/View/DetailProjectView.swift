//
//  DetalsProjectView.swift
//  Task
//
//  Created by Maja Frąk on 11/04/2025.
//

import SwiftUI

struct DetailProjectView: View {
    let project: ProjectModel
    @ObservedObject var appRouter: AppRouter
    
    var body: some View {
        VStack {
            HStack {
                backButton
                Spacer()
            }
            
            List {
                topView
                ownerView
                numbersView
                topicsView
                dateView
                licenseView
                linkView
            }
            .font(.subheadline)
        }
    }
    
    private var backButton: some View {
        Button(action: {
            appRouter.route(.trendingProjectsView)
        }) {
            Image(systemName: Icons.arrow)
            .foregroundColor(.primary)
            .padding()
        }
    }
    
    private var topView: some View {
        Section {
            VStack(alignment: .leading, spacing: .sizeMedium) {
                Text(project.name)
                    .font(.title2.bold())
                HStack {
                    Text(project.language ?? "")
                }
                
                if let description = project.description {
                    Text(description)
                        .font(.subheadline)
                }
            }
            .frame(height: .tabViewHeight)
        }
    }
    
    private var ownerView: some View {
        Section(Constants.ownerLabel) {
            HStack {
                AsyncImage(url: URL(string: project.owner.avatarURL)) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: .sizeLarge, height: .sizeLarge)
                Text(project.owner.login)
            }
        }
    }
    
    private var numbersView: some View {
        Section(Constants.numbersLabel) {
            HStack(spacing: .sizeMedium) {
                QuantityView(image: Icons.star, quantity: project.stargazersCount)
                QuantityView(image: Icons.fork, quantity: project.forksCount)
                QuantityView(image: Icons.hammer, quantity: project.openIssues)
                QuantityView(image: Icons.tray, quantity: project.size)
            }
        }
    }
    
    private var topicsView: some View {
        Section(Constants.topicsLabel) {
            let columns = [GridItem(.adaptive(minimum: .cardHeight), spacing: .sizeSmall)]
            LazyVGrid(columns: columns, alignment: .leading, spacing: .sizeSmall) {
                ForEach(project.topics, id: \.self) { topic in
                    Text("#\(topic)")
                        .font(.subheadline)
                }
            }
        }
    }
    
    private var dateView: some View {
        Section(Constants.dateslabel) {
            DateView(title: Constants.createdLabel, date: project.createdAt)
            DateView(title: Constants.pushedLabel, date: project.pushedAt)
            DateView(title: Constants.updatedLabel, date: project.updatedAt)
        }
    }
    
    private var licenseView: some View {
        Section(Constants.licenseLabel) {
            InfoRow(label: Constants.licenseLabel, value: project.license?.name ?? "")
        }
    }
    
    private var linkView: some View {
        Section(Constants.linkLabel) {
            HStack {
                if let url = URL(string: project.url) {
                    Link(destination: url) {
                        HStack {
                            Text(Constants.openLinkLabel)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DetailProjectView(project: ProjectModel(id: 7, fullName: "name", name: "name", owner: OwnerModel(login: "Login", id: 45, avatarURL: ""), description: "okedgfghghblj;lk dsyfgjkghkjh dsfg", language: "Swift", forksCount: 3, createdAt: Date(), pushedAt: Date(), updatedAt: Date(), archived: false, watchers: 345, stargazersCount: 345, size: 345, license: LicenseModel(key: "key", name: "name", spdxID: "2345", url: ""), topics: ["ios", "apple"], openIssues: 3455, url: "url", isPrivate: false), appRouter: AppRouter())
}

private extension DetailProjectView {
    struct Constants {
        static let ownerLabel = "Owner"
        static let numbersLabel = "Numbers"
        static let topicsLabel = "Topics"
        static let dateslabel = "Dates"
        static let createdLabel = "Created at"
        static let pushedLabel = "Last pushed"
        static let updatedLabel = "Last updated"
        static let licenseLabel = "License"
        static let linkLabel = "Open in GitHub"
        static let openLinkLabel = "Open in GitHub"
    }
    struct Icons {
        static let person = "person.crop.square.fill"
        static let star = "star.fill"
        static let fork = "tuningfork"
        static let hammer = "hammer.fill"
        static let arrow = "arrow.backward.square.fill"
        static let tray = "tray.fill"
    }
}
