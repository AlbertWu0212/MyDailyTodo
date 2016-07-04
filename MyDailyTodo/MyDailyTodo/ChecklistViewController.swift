//
//  ViewController.swift
//  Checklists
//
//  Created by M.I. Hollemans on 27/07/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
  
  let tagForTextLabelInCell = 1000
  let tagForCheckmarkLabelInCell = 1001
  
  let cellIdentifier = "ChecklistItem"
  
//  var items: [ChecklistItem]
  var checklist: Checklist!

//  // MARK: initialize
//  required init?(coder aDecoder: NSCoder) {
//    items = [ChecklistItem]()
//    super.init(coder: aDecoder)
////    loadChecklistItems()
//  }
  
  // MARK: View life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    title = checklist.name
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: TableView datasource & delegate
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return checklist.items.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
    
    let item = checklist.items[indexPath.row]
    
    configureTextForCell(cell, withChecklistItem: item)
    configureCheckmarkForCell(cell, withChecklistItem: item)

    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      let item = checklist.items[indexPath.row]
      item.toggleChecked()
      
      configureCheckmarkForCell(cell, withChecklistItem: item)
    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
//    saveChecklistItems()
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle,forRowAtIndexPath indexPath: NSIndexPath) {

    checklist.items.removeAtIndex(indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    
//    saveChecklistItems()
  }
  
  // MARK: Some private methods
  func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
    let label = cell.viewWithTag(tagForTextLabelInCell) as! UILabel
    label.text = item.text
  }
  
  func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
    let label = cell.viewWithTag(tagForCheckmarkLabelInCell) as! UILabel
    
    if item.checked {
      label.text = "√"
    } else {
      label.text = ""
    }
  }
  
  // MARK: ItemDetailViewController delegate
  func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
    let newRowIndex = checklist.items.count
    
    checklist.items.append(item)
    
    let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
    let indexPaths = [indexPath]
    tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    
    dismissViewControllerAnimated(true, completion: nil)
    
//    saveChecklistItems()
  }
  
  func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
    if let index = checklist.items.indexOf(item) {
      let indexPath = NSIndexPath(forRow: index, inSection: 0)
      if let cell = tableView.cellForRowAtIndexPath(indexPath) {
        configureTextForCell(cell, withChecklistItem: item)
      }
    }
    dismissViewControllerAnimated(true, completion: nil)
    
//    saveChecklistItems()
  }
  
  // MARK: Segue
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "AddItem" {
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! ItemDetailViewController
      controller.delegate = self

    } else if segue.identifier == "EditItem" {
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! ItemDetailViewController
      controller.delegate = self
      
      if let indexPath = tableView.indexPathForCell( sender as! UITableViewCell) {
        controller.itemToEdit = checklist.items[indexPath.row]
      }
    }
  }
}
