//
//  TaskDetailViewController.swift
//  Ajandam
//
//  Created by Yigit Bostanci on 12.05.2024.


//MARK: manage the screen where users can add/edit task details.

import UIKit

class TaskDetailViewController: UIViewController {
    
    @IBOutlet weak var personalButton: UIButton!
    @IBOutlet weak var shoppingButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var detailDescription: UITextField!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBAction func saveButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
