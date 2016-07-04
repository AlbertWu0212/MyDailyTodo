//
//  ViewController.swift
//  MyDailyTodo
//
//  Created by WuZhengBin on 16/7/4.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var items: [ChecklistItem]
    
    
    let tagForLabelInCell = 1000
    let tagForCheckmarkInCell = 1001

    required init?(coder aDecoder: NSCoder) {
        
        items = [ChecklistItem]()
        
        let row0item = ChecklistItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        items.append(row0item)
        
        let row1item = ChecklistItem()
        row1item.text = "Brush my teeth"
        row1item.checked = true
        items.append(row1item)
        
        let row2item = ChecklistItem()
        row2item.text = "Learn iOS development"
        row2item.checked = true
        items.append(row2item)
        
        let row3item = ChecklistItem()
        row3item.text = "Soccer practice"
        row3item.checked = false
        items.append(row3item)
        
        let row4item = ChecklistItem()
        row4item.text = "Eat ice cream"
        row4item.checked = true
        items.append(row4item)
        
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: TableView DataSource & Delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CheckListItem", forIndexPath: indexPath)
        let item = items[indexPath.row]
        
        
        configTextForCell(cell, withChecklistItem: item)
        configureCheckmarkForCell(cell, withChecklistItem: item)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        items.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    // MARK: Private methods
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        
        let label = cell.viewWithTag(tagForCheckmarkInCell) as! UILabel
                
        label.text = item.checked ? "✓" : ""
    }
    
    func configTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        
        let label = cell.viewWithTag(tagForLabelInCell) as! UILabel
        label.text = item.text
    }
    
    // MARK: Segue
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        let navigationController = segue.destinationViewController as! UINavigationController
////        let controller = navigationController.topViewController as! ItemDetailViewController
//        controller.delegate = self
//        
//        if segue.identifier == "AddItemSegue" {
//
//        } else if segue.identifier == "EditItemSegue" {
//            
//            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
//                controller.itemToEdit = items[indexPath.row]
//            }
//        }
//    }
//    
    // MARK: ItemDetailViewControllerDelegate
//    func ItemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
//    func ItemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
//        
//        let newRowIndex = items.count
//        items.append(item)
//        
//        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
//        let indexPaths = [indexPath]
//        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
//        
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
//    func ItemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
//        if let index = items.indexOf(item) {
//            let indexPath = NSIndexPath(forRow: index, inSection: 0)
//            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
//                configTextForCell(cell, withChecklistItem: item)
//            }
//        }
//        dismissViewControllerAnimated(true, completion: nil)
//    }
}

