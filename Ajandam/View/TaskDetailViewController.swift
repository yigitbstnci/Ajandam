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
  
    var todo: Task?
   
    var buttons: [UIButton] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [personalButton,shoppingButton,travelButton,phoneButton]
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func personalTapped(_ sender: UIButton) {
        resetButton()
        personalButton.isSelected = true
        personalButton.setImage(UIImage(named: "child-selected"), for: .normal)
        checkWhichSelected(selectedButton: sender)
        
    }
    
    @IBAction func shoppingTapped(_ sender: UIButton) {
        resetButton()
        checkWhichSelected(selectedButton: sender)
        shoppingButton.isSelected = true
        shoppingButton.setImage(UIImage(named: "shopping-cart-selected"), for: .normal)
        


    }
    
    @IBAction func travelTapped(_ sender: UIButton) {
        resetButton()
        checkWhichSelected(selectedButton: sender)
        travelButton.isSelected = true
        travelButton.setImage(UIImage(named: "travel-selected"), for: .normal)
    }
    
    @IBAction func phoneTapped(_ sender: UIButton) {
        resetButton()
        checkWhichSelected(selectedButton: sender)
        phoneButton.isSelected = true
        phoneButton.setImage(UIImage(named: "phone-selected"), for: .normal)
        
    }
    
    func checkWhichSelected (selectedButton: UIButton) {
        //my opinion not best choice for controller but its work
        for button in buttons {
                  if button != selectedButton {
                      switch button {
                          //not selected Button image
                                          case personalButton:
                                              button.setImage(UIImage(named: "child"), for: .normal)
                                          case shoppingButton:
                                              button.setImage(UIImage(named: "shopping-cart"), for: .normal)
                                          case travelButton:
                                              button.setImage(UIImage(named: "travel"), for: .normal)
                                          case phoneButton:
                                              button.setImage(UIImage(named: "phone"), for: .normal)
                                          default:
                                              break
                                      }
                                  } else {
                                      // selected button Setİmage
                                      switch button {
                                          case personalButton:
                                              button.setImage(UIImage(named: "child-selected"), for: .normal)
                                          case shoppingButton:
                                              button.setImage(UIImage(named: "shopping-cart-selected"), for: .normal)
                                          case travelButton:
                                              button.setImage(UIImage(named: "travel-selected"), for: .normal)
                                          case phoneButton:
                                              button.setImage(UIImage(named: "phone-selected"), for: .normal)
                                          default:
                                              break
                                      }
                  }
              }
        
    }
    //clear selected button
    func resetButton () {
        personalButton.isSelected = false
        shoppingButton.isSelected = false
        travelButton.isSelected = false
        phoneButton.isSelected = false
    }

    
    @IBAction func saveButton(_ sender: UIButton) {
        var image = ""
        //check which type selected
        if personalButton.isSelected {
            image = "child-selected"
        }else if shoppingButton.isSelected {
            image = "shopping-cart-selected"
        }else if travelButton.isSelected {
            image = "travel-selected"
        }else if phoneButton.isSelected {
            image = "phone-selected"
        }
        
        //check and set Task class
        if todo == nil {
            //set UUID for new task
            let uuid = UUID().uuidString
            todo = Task(id: uuid, title: todoTitle.text!, description: detailDescription.text!, date: datepicker.date,image: image)
            TaskManager.shared.addTask(todo!)
            navigationController?.popViewController(animated: true)
        }
        
    }

}
