//
//  TaskListController.swift
//  FirstApp
//
//  Created by alex on 8/8/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit
import CoreData

class TaskListController: UITableViewController, ActionResultDelegate {
    
    private var dateFormatter = DateFormatter()
    
    let taskDAO = TaskDAOImpl.current
    let categoryDAO = CategoryDAOImpl.current
    let priorityDAO = PriorityDAOImpl.current
    
    private var list:[Task]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        
        //taskDAO.initData()
        
        list = taskDAO.getAll()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TaskListViewCell else{
            fatalError("cell error")
        }

        let task = list[indexPath.row]
        
        cell.labelTaskName.text = task.name
        cell.labelTaskCategory.text = (task.category?.name ?? "")
        if let deadLine = task.deadline{
            cell.labelTaskDeadline.text = dateFormatter.string(from: deadLine as Date)
        }else {
            cell.labelTaskDeadline?.text = ""
        }
        
        cell.labelTaskDeadline?.textColor = UIColor.lightGray
        
        if let dif = task.daysLeft(){
            switch dif{
            case 0:
                cell.labelTaskDeadline?.text = "Today"
            case 1:
                cell.labelTaskDeadline?.text = "Tomorrow"
            case _ where dif > 0:
                cell.labelTaskDeadline?.text = "\(dif) days"
            case _ where dif < 0:
                cell.labelTaskDeadline?.textColor = UIColor.red
                cell.labelTaskDeadline?.text = "\(dif) days"
            default:
                cell.labelTaskDeadline?.text = ""
            }
        }else{
            cell.labelTaskDeadline?.text = ""
        }
        
        if let priority = task.priority {
            
            switch priority.index {
            case 1:
                cell.labelTaskPriority.backgroundColor = UIColor.green
            case 2:
                cell.labelTaskPriority.backgroundColor = UIColor.blue
            case 3:
                cell.labelTaskPriority.backgroundColor = UIColor.red
            default:
                cell.labelTaskPriority.backgroundColor = UIColor.white
            }
            
        }else {
            cell.labelTaskPriority.backgroundColor = UIColor.white
        }
        
        // Configure the cell...

        return cell
    }
    
    // set height row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    // delete row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete){
            taskDAO.delete(list[indexPath.row])
            
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }else if (editingStyle == .insert){
            // insert
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier! {
        case "editTask":
            let selectedCell = sender as! TaskListViewCell
            
            let selectedIndex = (tableView.indexPath(for: selectedCell)?.row)!
            
            let selectedTask = taskDAO.items[selectedIndex]
            
            guard let controller = segue.destination as? TaskDetailsController else{
                fatalError("error")
            }
            
            controller.title = "Edit"
            controller.task = selectedTask
            controller.delegate = self
        default:
            return
        }
    

    }
    
    // MARK: action 
    
    func done(source: UIViewController, data: Any?) {
        if source is TaskDetailsController{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                taskDAO.save()
                tableView.reloadRows(at: [selectedIndexPath], with: .fade)
            }
        }
    }
}
