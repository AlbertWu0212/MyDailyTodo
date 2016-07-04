//
//  Checklist.swift
//  MyDailyTodo
//
//  Created by WuZhengBin on 16/7/4.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

import UIKit
import Foundation

class Checklist: NSObject, NSCoding {

  var name = ""
  var iconName: String
  var items = [ChecklistItem]()
  
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObjectForKey("Name") as! String
    items = aDecoder.decodeObjectForKey("Items") as! [ChecklistItem]
    iconName = aDecoder.decodeObjectForKey("IconName") as! String
    super.init()
    
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: "Name")
    aCoder.encodeObject(items, forKey: "Items")
    aCoder.encodeObject(iconName, forKey: "IconName")
  }
  
  convenience init(name: String) {
    self.init(name: name, iconName: "No Icon")
  }
  
  init(name: String, iconName: String) {
    self.name = name
    self.iconName = iconName
    super.init()
  }
  
  func countUncheckedItems() -> Int {
    var count = 0
    for item in items where !item.checked {
      count += 1
    }
    return count
  }
  
}
