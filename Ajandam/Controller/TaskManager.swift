//
//  TaskManager.swift
//  Ajandam
//
//  Created by Yigit Bostanci on 12.05.2024.
//

import UIKit

class   TaskManager {
    static let  shared = TaskManager()
    private init() {}
    
    private var tasks: [Task] = [
    ]
    // Method to fetch tasks
    func fetchTasks() -> [Task] {
        return tasks
    }
    
    // Method to add a task
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    // Method to delete a task
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
    }
    
}
