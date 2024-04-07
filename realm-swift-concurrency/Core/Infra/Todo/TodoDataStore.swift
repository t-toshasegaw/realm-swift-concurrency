//
//  TodoDataStore.swift
//  

//
//  Created by 長谷川稔樹 on 2024/03/28.
//

import Foundation
import RealmSwift

final class TodoDataStore: TodoRepository {
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
}

extension TodoDataStore {
    func add(_ todo: TodoModel) async throws {
        let writer = await RealmWriter()
        try await writer.write(TodoEntity(model: todo))
    }
    
    func get() async -> AsyncThrowingStream<[TodoModel], any Error> {
        .init { continuation in
            let entities = realm.objects(TodoEntity.self)
            let token = entities.observe { change in
                switch change {
                case .initial(let value):
                    print("initial: ", value.count)
                    continuation.yield(value.map { $0.translate() })
                    
                case .update(let value, _, _, _):
                    print("update: ", value.count)
                    continuation.yield(value.map { $0.translate() })
                    
                case .error(let error):
                    print("error: ", error)
                    continuation.finish(throwing: error)
                }
            }
            
            continuation.onTermination = { _ in
                token.invalidate()
            }
        }
    }
}

@globalActor
actor RealmBackgroundActor: GlobalActor {
    static let shared = RealmBackgroundActor()
}

@RealmBackgroundActor
final class RealmWriter {
    private let realm: Realm
    
    init() async {
        self.realm = try! await Realm(actor: RealmBackgroundActor.shared)
    }
    
    func write(_ object: Object) async throws {
        try await realm.asyncWrite {
            realm.add(object)
        }
    }
}
