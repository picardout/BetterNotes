//
//  SummaryViewController.swift
//  BetterNotes
//
//  Created by Marius Pirvulescu on 2/25/18.
//  Copyright © 2018 Trinketronics. All rights reserved.
//

import UIKit
import CoreData

class SummaryViewController: UITableViewController {

    var arrNoteName : [Notes] = []
    let cntxt = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNoteName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

        cell.textLabel?.text = arrNoteName[indexPath.row].name
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selected row - show the note editor
        performSegue(withIdentifier: "showNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let targetNoteVC = segue.destination as! NotesViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            targetNoteVC.note = arrNoteName[indexPath.row]
        }
    }

    @IBAction func addNote(_ sender: UIBarButtonItem) {
        //add a new note and save the change to Core Data:
        let alert = UIAlertController(title: "Provide a name for the new note", message: "", preferredStyle: .alert)
        //method-level variable used to extract info from the closure
        var theTextField = UITextField();
        let newAlert = UIAlertAction(title: "Add", style: UIAlertActionStyle.default) { (action) in
            let newNote = Notes(context: self.cntxt)
            newNote.name = theTextField.text
            newNote.text = ""
            self.arrNoteName.append(newNote)
            self.saveData()
        }
        alert.addAction(newAlert)
        alert.addTextField { (textField) in
            textField.placeholder = "Create new note"
            theTextField = textField
        }
        present(alert, animated: true, completion: nil)

    }
    

    // MARK: - Save/Retrieve core data
    
    func saveData() {
        do {
            try (cntxt.save())
        } catch {
            print ("Error when saving data" + "\(error)")
        }
        tableView.reloadData()
    }
    
    func loadData() {
        let request : NSFetchRequest<Notes> = Notes.fetchRequest()
        do {
            arrNoteName = try (cntxt.fetch(request))
        } catch {
            print ("Error when loading data" + "\(error)")
        }
        tableView.reloadData()
    }


}

extension SummaryViewController {
    
}
