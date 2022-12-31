//
//  ToDoViewController.swift
//  iOS-1-Final-Exam
//
//  Created by Fenil Bhanavadiya on 2022-12-17.
//

import UIKit
import FirebaseFirestore

class ToDoViewController: UIViewController {
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet weak var remindersTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var reminders: [Reminder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.layer.cornerRadius = addButton.frame.width / 2
        addButton.layer.masksToBounds = true
        
        remindersTableView.dataSource = self
        remindersTableView.delegate = self
        
        remindersTableView.register(UINib(nibName: "ReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "reminder-cell")
        
        loadReminders()

    }
    
    func loadReminders() {
        db.collection("Reminders").getDocuments { querySnapshot, error in
            self.reminders = []
            if error == nil {
                if let documents = querySnapshot?.documents {
                    for document in documents {
                        let reminder = Reminder(title: document["title"] as! String,
                                                  notes: document["notes"] as! String)
                        self.reminders.append(reminder)
                        DispatchQueue.main.async {
                            self.remindersTableView.reloadData()
                        }
                    }
                }
            }
        }
    }

    @IBAction func addButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "new-reminder", sender: self)
    }
    
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = remindersTableView.dequeueReusableCell(withIdentifier: "reminder-cell", for: indexPath) as! ReminderTableViewCell
        
        cell.reminderTitle.text = reminders[indexPath.row].title
        
        return cell
    }
    
}
