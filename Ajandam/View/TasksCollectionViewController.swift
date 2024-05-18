//
//  TasksCollectionViewController.swift
//  Ajandam
//
//  Created by Yigit Bostanci on 12.05.2024.
//
// MARK: - manage the main screen displaying the list of tasks using a UICollectionView.

import UIKit

private let reuseIdentifier = "TaskCell"
var tasks: [Task] = [] // Task data array
var selectedCellIds: [String] = []

class TasksCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
        let floatButton = UIButton(type: .custom)
        
    
    // MARK: - Fetch Data
    
    func fetchData() {
        tasks = TaskManager.shared.fetchTasks()
        collectionView.reloadData()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ajandam"
        collectionView.allowsSelection = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
        
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TaskCell
        let task = tasks[indexPath.item]
        cell.configure(with: task)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .lightGray
        let selectedId = tasks[indexPath.item].id
        selectedCellIds.append(selectedId)
        if selectedCellIds.count == 1 {
            floatButton.isHidden = false
        }else {
            floatButton.isHidden = true
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .white
        let deselectedId = tasks[indexPath.item].id
        if let index = selectedCellIds.firstIndex(of: deselectedId) {
            selectedCellIds.remove(at: index)
            if selectedCellIds.isEmpty {
                floatButton.isHidden = true
            }else if selectedCellIds.count > 1 {
                floatButton.isHidden = true
            }else   {
                floatButton.isHidden = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    // MARK: - Button Actions, activity
    
    @objc func addButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! TaskDetailViewController
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc func editButtonTapped() {
        collectionView.allowsMultipleSelection = true
        collectionView.allowsSelection = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(closeEditMode))
        createFloatButton()
    }
    
    
    @objc func deleteButtonTapped() {
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        //alert for remove Task
        let ac = UIAlertController(title: "Ajandam", message: "Planlanmış Görevi Silmek İster misin ?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Sil", style: .default, handler: deleteFunc))
        ac.addAction(UIAlertAction(title: "Vazgeç", style: .destructive, handler: nil))
        present(ac, animated: true)
        
        // Deselect the selected item and set the background color to white
        for indexPath in collectionView.indexPathsForVisibleItems {
            collectionView.deselectItem(at: indexPath, animated: true)
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = .white
        }
        
    }
    
    @objc func closeEditMode() {
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        collectionView.visibleCells.forEach {$0.backgroundColor = .white}
        floatButton.isHidden = true
        selectedCellIds.removeAll(keepingCapacity: false)
    }
    
    func deleteFunc(alert: UIAlertAction) {
        // Remove the selected tasks
        for id in selectedCellIds {
            if let index = tasks.firstIndex(where: { $0.id == id }) {
                TaskManager.shared.deleteTask(at: index)
            }
        }
        // Reload collection view data
        fetchData()
        floatButton.isHidden = true
    }

    
    func createFloatButton () {
        floatButton.setImage(UIImage(named: "pencil"), for: .normal)
        floatButton.backgroundColor = .systemBlue
        floatButton.setTitleColor(.white, for: .normal)
        floatButton.layer.cornerRadius = 25
        floatButton.layer.masksToBounds = true
        floatButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatButton)
        floatButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        floatButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        floatButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        floatButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        floatButton.addTarget(self, action: #selector(floatButtonTapped), for: .touchUpInside)
        floatButton.isHidden = true
    }
    
    @objc func floatButtonTapped() {
        //selected task ID navigate to detailpage to show
        if let selectedTaskID = selectedCellIds.first {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! TaskDetailViewController
            detailVC.selectedID = selectedTaskID
            navigationController?.pushViewController(detailVC, animated: true)
        }
        closeEditMode()
       
    }
}



































// MARK: - TaskCell

class TaskCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taskTypeImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with task: Task) {
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        let dateString = dateFormatter.string(from: task.date)
        dateLabel.text = dateString
        taskTypeImage.image = UIImage(named: task.image)
        descriptionLabel.sizeToFit()
        descriptionLabel.numberOfLines = 2
        
    }
}
