//
//  TodoListGetInteractor.swift
//  realm-swift-concurrency
//
//  Created by 長谷川稔樹 on 2024/04/07.
//

import Foundation

protocol TodoListGetUsecase {
    func execute() async -> AsyncThrowingStream<[TodoModel], any Error>
}

final class TodoListGetInteractor: TodoListGetUsecase {
    private let todoDataStore: any TodoRepository
    
    init(todoDataStore: some TodoRepository) {
        self.todoDataStore = todoDataStore
    }
}

extension TodoListGetInteractor {
    func execute() async -> AsyncThrowingStream<[TodoModel], any Error> {
        await todoDataStore.get()
    }
}
