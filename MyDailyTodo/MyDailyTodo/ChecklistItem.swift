//
//  ChecklistItem.swift
//  Checklists
//
//  Created by M.I. Hollemans on 27/07/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
  var text = ""
  var checked = false
  
  func toggleChecked() {
    checked = !checked
  }
}
