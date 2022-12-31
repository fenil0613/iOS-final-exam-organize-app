//
//  NewReminderViewController.swift
//  iOS-1-Final-Exam
//
//  Created by Fenil Bhanavadiya on 2022-12-18.
//

import UIKit
import FirebaseFirestore

class NewReminderViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var reminderTitle: UITextField!
    @IBOutlet weak var category: UIButton!
    
    let db = Firestore.firestore()
    
    let formatter = DateFormatter()
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func createClicked(_ sender: UIButton) {
        
        if let title = reminderTitle.text, let notes = notes.text {
            
            db.collection("Reminders").addDocument(data: ["title" : title, "notes": notes]) { (error) in
                if error == nil {
                    print("Data Saved successfully")
                } else {
                    print("Error while inserting at firebase")
                }
            }
            
            performSegue(withIdentifier: "create-to-list", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "create-to-list" {
            let destination = segue.destination as? ToDoViewController
            
            datePicker.datePickerMode = .date
            datePicker.addTarget(self, action: #selector(datePickerChanged(sender: )),
                                 for: UIControl.Event.valueChanged)
        }
    }
    
    @objc func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        date = formatter.string(from: sender.date)
    }
}
