//
//  DataModel.swift
//  MyDailyTodo
//
//  Created by WuZhengBin on 16/7/4.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

import Foundation

class DataModel {
  
  var lists = [Checklist]()
  var indexOfSelectedChecklist: Int {
    get {
      return NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
    }
    set {
      NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "ChecklistIndex")
      NSUserDefaults.standardUserDefaults().synchronize()
    }
  }
  
  
  func documentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    return paths[0]
  }
  
  func dataFilePath() -> String {
    let directory = documentsDirectory() as NSString
    return directory.stringByAppendingPathComponent("Checklists.plist")
  }
  
  func saveChecklists() {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    archiver.encodeObject(lists, forKey: "Checklists")
    archiver.finishEncoding()
    data.writeToFile(dataFilePath(), atomically: true)
  }
  
  func loadChecklist() {
    let path = dataFilePath()
    if NSFileManager.defaultManager().fileExistsAtPath(path) {
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        lists = unarchiver.decodeObjectForKey("Checklists") as! [Checklist]
        unarchiver.finishDecoding()
        sortChecklist()
      }
    }
  }
  
  func registerDefaults() {
    let dictionary = [ "ChecklistIndex": -1 ,
                       "FirstTime": true,
                       "ChecklistItemID": 0 ]
    NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
  }
  
  func handleFirstTime() {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let firstTime = userDefaults.boolForKey("FirstTime")
    if firstTime {
      let checklist = Checklist(name: "List")
      lists.append(checklist)
      indexOfSelectedChecklist = 0
      userDefaults.setBool(false, forKey: "FirstTime")
      userDefaults.synchronize()
    }
  }
  
  func sortChecklist() {
    lists.sortInPlace({ checklist1, checklist2 in return
      checklist1.name.localizedStandardCompare(checklist2.name) == .OrderedAscending
    })
  }
  
  class func nextChecklistItemID() -> Int {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let itemID = userDefaults.integerForKey("ChecklistItemID")
    userDefaults.setInteger(itemID + 1, forKey: "ChecklistItemID")
    userDefaults.synchronize()
    return itemID
  }
  
  init() {
    loadChecklist()
    registerDefaults()
    handleFirstTime()
  }
}
