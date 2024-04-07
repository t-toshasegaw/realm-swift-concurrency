//
//  TodoEntity.swift
//  realm-swift-concurrency
//
//  Created by 長谷川稔樹 on 2024/03/28.
//

import Foundation
import RealmSwift

final class TodoEntity: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    convenience init(model: TodoModel) {
        self.init()
        
        self.id = UUID().uuidString
        self.name = model.name
    }
    
    func translate() -> TodoModel {
        .init(name: name)
    }
}
