//
//  IconPickerViewController.swift
//  MyDailyTodo
//
//  Created by WuZhengBin on 16/7/4.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

import UIKit

protocol IconPickerControllerDelegate: class {
  func iconPicker(picker: IconPickerViewController, didPickIcon iconName: String)
}

class IconPickerViewController: UITableViewController {

  weak var delegate: IconPickerControllerDelegate?
  let icons = [ "No Icon",
                "Appointments",
                "Birthdays",
                "Chores",
                "Drinks",
                "Folder",
                "Groceries",
                "Inbox",
                "Photos",
                "Trips" ]
  
  override func viewDidLoad() {
      super.viewDidLoad()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return icons.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("IconCell", forIndexPath: indexPath)
    let iconName = icons[indexPath.row]
    cell.textLabel!.text = iconName
    cell.imageView!.image = UIImage(named: iconName)
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let delegate = delegate {
      let iconName = icons[indexPath.row]
      delegate.iconPicker(self, didPickIcon: iconName)
    }
  }
  
}
