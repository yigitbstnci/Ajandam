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
    var id: String
    var title: String
    var description: String
    var date: Date
    var image: String
    init(id: String, title: String, description: String, date: Date, image: String) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.image = image
    }
}
