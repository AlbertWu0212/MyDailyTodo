//
//  ChecklistItem.swift
//  Checklists
//
//  Created by M.I. Hollemans on 27/07/15.
//  Copyright © 2015 Razeware. All rights reserved.
//
import UIKit
import Foundation

class ChecklistItem: NSObject, NSCoding {
  var text = ""
  var checked = false
  var dueDate = NSDate()
  var shouldRemind = false
  var itemID: Int
  
  // MARK: NSCoding protocol
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(text, forKey: "Text")
    aCoder.encodeBool(checked, forKey: "Checked")
    aCoder.encodeObject(dueDate, forKey: "DueDate")
    aCoder.encodeBool(shouldRemind, forKey: "ShouldRemind")
    aCoder.encodeInteger(itemID, forKey: "ItemID")
  }
  
  // MARK: initialize
  required init?(coder aDecoder: NSCoder) {
    text = aDecoder.decodeObjectForKey("Text") as! String
    checked = aDecoder.decodeBoolForKey("Checked")
    dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
    shouldRemind = aDecoder.decodeBoolForKey("ShouldRemind")
    itemID = aDecoder.decodeIntegerForKey("ItemID")
    super.init()
  }
  
  override init() {
    itemID = DataModel.nextChecklistItemID()
    super.init()
  }
  
  // Deinitialize
  deinit {
    if let notification = notificationForThisItem() {
      UIApplication.sharedApplication().cancelLocalNotification(notification)
    }
  }
  
  // API Methods
  func toggleChecked() {
    checked = !checked
  }
  
  func scheduleNotification() {
    
    let existingNotification = notificationForThisItem()
    if let notification = existingNotification {
      UIApplication.sharedApplication().cancelLocalNotification(notification)
    }
    
    if shouldRemind && dueDate.compare(NSDate()) != .OrderedAscending {
      let localNotification = UILocalNotification()
      localNotification.fireDate = dueDate
      localNotification.timeZone = NSTimeZone.defaultTimeZone()
      localNotification.alertBody = text
      localNotification.soundName = UILocalNotificationDefaultSoundName
      localNotification.userInfo = ["ItemID": itemID]
      UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
      print("Scheduled notification \(localNotification) for itemID \(itemID)")
      
    }
  }
  
  // Private methods
  private func notificationForThisItem() -> UILocalNotification? {
    let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications!
    for notification in allNotifications {
      if let number = notification.userInfo?["ItemID"] as? Int where number == itemID {
        return notification
      }
    }
    return nil
  }
}
