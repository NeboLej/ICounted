//
//  DBRepository.swift
//  ICounted
//
//  Created by Nebo on 02.12.2024.
//

import Foundation
import SwiftData

class DBRepository {
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func getAll<T>() throws -> [T] where T: PersistentModel {
        let fetchDescriptor = FetchDescriptor<T>()
        return try context.fetch(fetchDescriptor)
    }
    
    func save<T>(model: T) throws where T: PersistentModel {
        context.insert(model)
        try context.save()
    }
    
    func getByID<T>(id: UUID) throws -> T? where T: HasUUID {
        var descriptor = FetchDescriptor<T>(predicate: #Predicate { $0.id == id })
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }
    
    func delete<T>(model: T) throws where T: PersistentModel {
        context.delete(model)
        try context.save()
    }
}

protocol HasUUID: PersistentModel {
    var id: UUID { get set }
}
