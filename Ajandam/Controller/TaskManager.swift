//
//  TaskManager.swift
//  Ajandam
//
//  Created by Yigit Bostanci on 12.05.2024.
//

import UIKit

class   TaskManager {
    static let  shared = TaskManager()
    private init() {
        self.tasks = []
    }
    
    private var tasks: [Task] = [
    ]
    // Method to fetch tasks
    func fetchTasks() -> [Task] {
        loadTasks() 
        return tasks
    }
    
    // Method to add a task
    func addTask(_ task: Task) {
        tasks.append(task)
        saveTasks()
    }
    
    // Method to delete a task
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
        saveTasks()
    }
    //USerdata Things  SC:https://medium.com/batech/swift-notlar%C4%B1-2-user-defaults-3a60c615d6c8
    func saveTasks() {
        do {
            let encodedData = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(encodedData, forKey: "tasks")
        }catch {
            print("UserDefault Encode Error")
        }
    }
    func loadTasks(){
        if let encodedData = UserDefaults.standard.data(forKey: "tasks"){
            do {
                tasks = try JSONDecoder().decode([Task].self, from: encodedData)
                print("Get data complate")
            }catch {
                print("USerDefault decode error ")
            }
        }
    }
    
}
