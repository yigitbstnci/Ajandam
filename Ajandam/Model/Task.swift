//
//  Task.swift
//  Ajandam
//
//  Created by Yigit Bostanci on 12.05.2024.
//MARK: Class with title, description,priority, date and completion

import Foundation
import UIKit

//class for task

class Task {
    var title: String
    var description: String?
    var date: Date
    
    init(title: String, description: String? = nil, date: Date) {
        self.title = title
        self.description = description
        self.date = date
    }
}
