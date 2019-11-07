//
//  AddBirthday.swift
//  HBDReminder
//
//  Created by armin on 11/7/19.
//  Copyright © 2019 shalchian. All rights reserved.
//

import UIKit

class AddBirthday: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    

    @IBAction func indexChanged(_ sender: Any) {
        switch pickerSegmentedControl.selectedSegmentIndex {
        case 0:
            datePicker.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        case 1:
            datePicker.calendar = Calendar(identifier: Calendar.Identifier.persian)
        default:
            break;
        }
    }

    @IBAction func savePressed(_ sender: Any) {
        if (!nameField.text!.isEmpty) {
            self.save { (complete) in
                if complete {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadTable"), object: nil)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let birthday = Birthday(context: managedContext)
        birthday.id = UUID.init()
        birthday.name = nameField.text!
        birthday.date = datePicker.date
        
        do {
            try managedContext.save()
            completion(true)
            
        } catch {
            debugPrint("🔴Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
}
