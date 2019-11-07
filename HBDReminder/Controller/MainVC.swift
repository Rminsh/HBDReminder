//
//  MainVC.swift
//  HBDReminder
//
//  Created by armin on 11/6/19.
//  Copyright © 2019 shalchian. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var peopleTable: UITableView!
    @IBOutlet weak var emptyState: UIStackView!
    var items: [Birthday] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "people_list", for: indexPath) as! PeopleListCell
        let _items = items [indexPath.row]
        cell.updateUI(items: _items)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.remove(atIndexPath: indexPath)
            self.fetchSavedData()
            self.peopleTable.deleteRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return [deleteAction]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable(_:)), name: Notification.Name(rawValue: "reloadTable"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchSavedData()
        peopleTable.reloadData()
    }
    
    func fetchSavedData() {
        self.fetch { (complete) in
            if complete {
                if items.count >= 1 {
                    peopleTable.isHidden = false
                    emptyState.isHidden = true
                    
                } else {
                    peopleTable.isHidden = true
                    emptyState.isHidden = false
                }
            }
        }
    }
    
    @objc func refreshTable(_ notification: Notification) {
        peopleTable.reloadData()
    }
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Birthday>(entityName: "Birthday")
        do {
            items = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("🔴Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
    func remove(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(items[indexPath.row])
        
        do {
            try managedContext.save()
            
        } catch {
            debugPrint("🔴Could not save: \(error.localizedDescription)")
        }
    }
}
