//
//  TodoListView.swift
//  realm-swift-concurrency
//
//  Created by 長谷川稔樹 on 2024/03/27.
//

import SwiftUI

struct TodoListView: View {
    @StateObject var viewModel = TodoListViewModel()
    
    var body: some View {
        List {
            HStack {
                Text("test")
                Spacer()
                Button {
                    Task {
                        await viewModel.add("hoge")
                    }
                } label: {
                    Text("追加")
                }
                .buttonStyle(.plain)
                .foregroundStyle(.blue)
            }
        }
        .task {
            await viewModel.get()
        }
    }
}

#Preview {
    TodoListView()
}
