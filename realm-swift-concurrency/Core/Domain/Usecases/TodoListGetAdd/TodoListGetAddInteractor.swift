//
//  TodoListGetAddInteractor.swift
//  realm-swift-concurrency
//
//  Created by 長谷川稔樹 on 2024/04/07.
//

import Foundation

protocol TodoListGetAddUsecase {
    func execute(input: TodoModel) async throws
}

final class TodoListGetAddInteractor: TodoListGetAddUsecase {
    private let todoDataStore: any TodoRepository
    
    init(todoDataStore: some TodoRepository) {
        self.todoDataStore = todoDataStore
    }
}

extension TodoListGetAddInteractor {
    func execute(input: TodoModel) async throws {
        try await todoDataStore.add(input)
    }
}
