//
//  TodoRepository.swift
//  realm-swift-concurrency
//
//  Created by 長谷川稔樹 on 2024/04/07.
//

import Foundation

@MainActor
protocol TodoRepository {
    func add(_ todo: TodoModel) async throws
    func get() async -> AsyncThrowingStream<[TodoModel], any Error>
}
