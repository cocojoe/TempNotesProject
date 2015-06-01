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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let myNote = Note()
        myNote.title   = "Super Simple Test Note"
        myNote.content = "A long piece of content"
        
        let realm = RLMRealm.defaultRealm()
        realm.transactionWithBlock() {
            //realm.deleteAllObjects(); // Testing
            realm.addObject(myNote)
        }
        
        notes = Note.allObjects();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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