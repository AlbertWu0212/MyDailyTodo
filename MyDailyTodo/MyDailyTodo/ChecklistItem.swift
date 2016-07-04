//
//  ChecklistItem.swift
//  Checklists
//
//  Created by M.I. Hollemans on 27/07/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
  var text = ""
  var checked = false
  
  func toggleChecked() {
    checked = !checked
  }
  
  // MARK: NSCoding protocol
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(text, forKey: "Text")
    aCoder.encodeBool(checked, forKey: "Checked")
  }
  
  required init?(coder aDecoder: NSCoder) {
    text = aDecoder.decodeObjectForKey("Text") as! String
    checked = aDecoder.decodeBoolForKey("Checked")
    super.init()
  }
  
  init(text: String, checked: Bool) {
    self.text = text
    self.checked = checked
    super.init()
  }
  
}
