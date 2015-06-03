//
//  NoteDisplayViewController.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 03/06/2015.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import Realm
import ConvenienceKit

class NoteDisplayViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: TextView!
    
    var note: Note? {
        didSet {
            displayNote(self.note)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        displayNote(self.note)
    }
    
    //MARK: Business Logic
    
    func displayNote(note: Note?) {
        if let note = note, titleTextField = titleTextField, contentTextView = contentTextView  {
            titleTextField.text = note.title
            contentTextView.text = note.content
        }
    }
    
}
