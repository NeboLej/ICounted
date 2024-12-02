//
//  TaskListPersistence.swift
//  TasksAlarm
//
//  Created by Nebo on 13.10.2024.
//

import Foundation
import SwiftData

struct TaskListPersistence: Middleware {
    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func process(action: TaskListAction, state: TaskListState, next: @escaping (TaskListAction) -> Void) {
        switch action {
        case .addTask(let newTask):
            context.insert(newTask)
            try? context.save()
            next(.tasksLoaded(loadTasksFromDB()))
        case .removeTask(let id):
            if let taskToRemove = state.tasks.first(where: { $0.id == id }) {
                context.delete(taskToRemove)
                try? context.save()
                next(.tasksLoaded(loadTasksFromDB()))
            }
        case .loadTasks:
            let tasks = loadTasksFromDB()
            next(.tasksLoaded(tasks))
        default:
            next(action)
        }
    }

    private func loadTasksFromDB() -> [TaskModel] {
        do {
            let fetchDescriptor = FetchDescriptor<TaskModel>()
            return try context.fetch(fetchDescriptor)
        } catch {
            print("Ошибка загрузки задач: \(error)")
            return []
        }
    }
}
