//
//  ViewController.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import UIKit
import Realm

class NotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes: RLMResults! {
        didSet {
            // Whenever notes update, update the table view
            if let tableView = tableView {
                tableView.reloadData()
            }
        }
    }
    
    // temporarily stores the note that a user selected by tapping a cell
    var selectedNote: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        notes = Note.allObjects().sortedResultsUsingProperty("modificationDate", ascending: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        
        if let identifier = segue.identifier {
            let realm = RLMRealm.defaultRealm()
            
            switch identifier {
            case "Save":
                let source = segue.sourceViewController as! NewNoteViewController
                
                realm.transactionWithBlock() {
                    realm.addObject(source.currentNote)
                }
            case "Delete":
                realm.transactionWithBlock() {
                    realm.deleteObject(self.selectedNote)
                }
            default:
                println("No one loves me")
            }
        }
        
        notes = Note.allObjects().sortedResultsUsingProperty("modificationDate", ascending: false)
        
    }
}

extension NotesViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath) as! NoteTableViewCell

        let row = UInt(indexPath.row)
        let note = notes[row] as! Note
        cell.note = note
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(notes?.count ?? 0)
    }
    
}

extension NotesViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedNote = notes.objectAtIndex(UInt(indexPath.row)) as? Note
        self.performSegueWithIdentifier("ShowExistingNote", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let note = notes[UInt(indexPath.row)] as! RLMObject
            
            let realm = RLMRealm.defaultRealm()
            
            realm.transactionWithBlock() {
                realm.deleteObject(note)
            }
            
            notes = Note.allObjects().sortedResultsUsingProperty("modificationDate", ascending: false)
        }
    }

}