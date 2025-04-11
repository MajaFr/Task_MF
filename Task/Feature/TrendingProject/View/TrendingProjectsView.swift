//
//  TrendingProjectsView.swift
//  Task
//
//  Created by Maja Frąk on 10/04/2025.
//

import SwiftUI

struct TrendingProjectsView: View {
    @ObservedObject var viewModel: TrendingProjectsViewModel
    @EnvironmentObject private var appRouter: AppRouter
    
    var body: some View {
        NavigationStack {
            topView
            ScrollView {
                LazyVStack(spacing: .sizeMedium) {
                    ForEach(viewModel.filteredItems) { project in
                        ProjectRowView(project: project)
                            .onTapGesture {
                                appRouter.route(.detailView(project: project))
                            }
                    }
                }
                .padding(.top)
            }

        }
        .onAppear {
            guard viewModel.items.isEmpty else { return }
            Task {
                await viewModel.getListProjects()
            }
        }
    }
    
    private var topView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Constants.helloLabel)
                    .font(.headline)
                    .foregroundColor(.gray)
                HStack {
                    Text(Constants.walletTitle)
                        .font(.title2)
                        .bold()
                    Spacer()
                    languagePicker
                }
            }
            Spacer()
        }
        .padding()
    }
    
    private var languagePicker: some View {
        Picker(Constants.languageTitle, selection: $viewModel.selectedLanguage) {
            Text(Constants.allLanguageTitle).tag(nil as String?)

            ForEach(viewModel.availableLanguages, id: \.self) { language in
                Text(language).tag(language as String?)
            }
        }
        .tint(.gray)
        .pickerStyle(.menu)
    }
}

#Preview {
    TrendingProjectsView(viewModel: TrendingProjectsViewModel())
}

private extension TrendingProjectsView {
    struct Constants {
        static let helloLabel = "Hello!"
        static let walletTitle = "Trending Projects"
        static let languageTitle = "Language"
        static let allLanguageTitle = "All Languages"
    }
}
