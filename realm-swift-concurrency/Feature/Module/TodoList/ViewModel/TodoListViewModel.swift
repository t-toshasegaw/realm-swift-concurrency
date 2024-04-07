//
//  TodoListViewModel.swift
//  realm-swift-concurrency
//
//  Created by 長谷川稔樹 on 2024/03/27.
//

import Foundation

@MainActor
final class TodoListViewModel: ObservableObject {
    private let todoListAddInteractor: TodoListGetAddUsecase
    private let todoListGetInteractor: TodoListGetUsecase
    
    init() {
        let todoDataStore = TodoDataStore()
        todoListAddInteractor = TodoListGetAddInteractor(todoDataStore: todoDataStore)
        todoListGetInteractor = TodoListGetInteractor(todoDataStore: todoDataStore)
    }
}

extension TodoListViewModel {
    func add(_ name: String) async {
        do {
            let todo = TodoModel(name: name)
            try await todoListAddInteractor.execute(input: todo)
        } catch {
            print("add error: ", error)
        }
    }
    
    func get() async {
        do {
            for try await todoList in await todoListGetInteractor.execute() {
                print("todoList: ", todoList.count)
            }
        } catch {
            print("get error: ", error)
        }
    }
}
