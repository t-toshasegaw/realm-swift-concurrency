//
//  TodoDataStoreTest.swift
//  realm-swift-concurrency
//
//  Created by 長谷川稔樹 on 2024/04/07.
//

@testable import realm_swift_concurrency
import RealmSwift
import XCTest

@MainActor
final class TodoDataStoreTest: XCTestCase {
    private var dataStore: TodoDataStore!
    private var realm: Realm!

    override func setUp() async throws {
        try await super.setUp()
        
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        realm = try! await Realm()
        
        dataStore = .init()
    }
    
    override func tearDown() async throws {
        try await super.tearDown()
    }
    
    func test_add_呼ばれたとき_データが保存される() async throws {
        for i in 0..<10 {
            let todo = TodoModel(name: "\(i)")
            try await dataStore.add(todo)
        }
        
        let entity = realm.objects(TodoEntity.self)
        XCTAssertTrue(entity.count == 10)
    }
    
    func test_get_データが保存されていないとき_空が返却される() async throws {
        for try await todoList in await dataStore.get().prefix(1) {
            XCTAssertTrue(todoList.isEmpty)
        }
    }
    
    func test_get_データが保存されているとき_保存しているデータが返却される() async throws {
        for i in 0..<10 {
            let todo = TodoModel(name: "\(i)")
            try! await realm.asyncWrite {
                realm.add(TodoEntity(model: todo))
            }
        }
        
        for try await todoList in await dataStore.get().prefix(1) {
            XCTAssertTrue(todoList.count == 10)
        }
    }
}
