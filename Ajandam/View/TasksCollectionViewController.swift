//
//  TasksCollectionViewController.swift
//  Ajandam
//
//  Created by Yigit Bostanci on 12.05.2024.
//
//MARK: manage the main screen displaying the list of tasks using a UICollectionView.

import UIKit

private let reuseIdentifier = "TaskCell"
var tasks: [Task] = [] //task data array

class TasksCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ajandam"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        // load task from UserDefaults
        //  tasks = TaskManager.shared.fetchTasks()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tasks = TaskManager.shared.fetchTasks()
        collectionView.reloadData()
        
    }
    
    @objc func addButtonTapped () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! TaskDetailViewController
        self.navigationController?.pushViewController(detailVc, animated: true)
        
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TaskCell
        let task = tasks[indexPath.item]
        
        cell.configure(with: task)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 100)
    }
    
    
}







//MARK: TaskCell

class TaskCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taskTypeImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    func configure (with task: Task) {
        titleLabel.text = task.title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = task.description
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
        let dateString = dateFormatter.string(from: task.date)
        dateLabel.text = dateString
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        taskTypeImage.image = UIImage(named: task.image)
    }
    
}
