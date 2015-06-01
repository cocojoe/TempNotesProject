//
//  Note.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import Foundation
import Realm

class Note : RLMObject {
    dynamic var title: String = ""
    dynamic var content: String = ""
    dynamic var modificationDate = NSDate()
}