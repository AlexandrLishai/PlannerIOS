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
    
    // sections of table
    let quickTaskSection = 0
    let taskListSection = 1
    
    let sectionCount = 2
    
    var textQuickTask:UITextField!
    //@IBOutlet var tableView: UITableView!
    
    var searchController:UISearchController! // search area
    
    var taskCount:Int{
        return taskDAO.items.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        
        setupSearchController()
        
        //taskDAO.initData()
        //taskDAO.search("a")
        
        
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
        return sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case quickTaskSection:
            return 1
        case taskListSection:
            return taskCount
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case quickTaskSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellQuickTask", for: indexPath) as? QuickTaskCell else{
                fatalError("cell error")
            }
            textQuickTask = cell.textQuickTask
            textQuickTask.placeholder = "Enter name of new task"
            return cell
        case taskListSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TaskListViewCell else{
                fatalError("cell error")
            }
            
            let task = taskDAO.items[indexPath.row]
            
            cell.labelTaskName.text = task.name
            cell.labelTaskCategory.text = (task.category?.name ?? "not choosen")
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
            if task.completed{
                cell.labelTaskName.textColor = UIColor.lightGray
                cell.labelTaskCategory.textColor = UIColor.lightGray
                cell.labelTaskDeadline.textColor = UIColor.lightGray
                cell.labelTaskPriority.backgroundColor = UIColor.lightGray
                cell.selectionStyle = .none
                cell.buttonCompleteTask.setImage(UIImage(named: "check_green"), for: .normal)
            }else{
                cell.selectionStyle = .default
                cell.buttonCompleteTask.setImage(UIImage(named: "check_gray"), for: .normal)
                cell.labelTaskName.textColor = UIColor.darkGray
            }
            
            return cell
            
            
        default:
            return UITableViewCell()
        }
    }
    
    // set height row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case quickTaskSection:
            return 40
        case taskListSection:
            return 60
        default:
            return 60
        }
    }
    
    // click on row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if taskDAO.items[indexPath.row].completed == true{
            return
        }
        if indexPath.section != quickTaskSection{
            performSegue(withIdentifier: "editTask", sender: tableView.cellForRow(at: indexPath))
        }
    }
    
    // can edit row
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == quickTaskSection{
            return false
        }
        return true
    }
    
    // delete row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete){
            deleteTask(indexPath)
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
            
            controller.title = "Edit Task"
            controller.task = selectedTask
            controller.delegate = self
        case "addTask":
            
            guard let controller = segue.destination as? TaskDetailsController else{
                fatalError("error")
            }
            
            controller.title = "New Task"
            controller.task = Task(context: taskDAO.context)
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
            }else{
                let task = data as! Task
                createTask(task)
            }
        }
    }
    
    @IBAction func deleteTaskAction(segue: UIStoryboardSegue) {
        guard segue.source is TaskDetailsController else{
            fatalError("error")
        }
        
        if segue.identifier == "DeleteTaskFromDetails" , let selectedIndexPath = tableView.indexPathForSelectedRow{
            deleteTask(selectedIndexPath)
        }
    }
    
    
    @IBAction func clickCompleteButton(_ sender: UIButton) {
        
        let viewPosition = sender.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: viewPosition)!
        
        guard (tableView.cellForRow(at: indexPath) as? TaskListViewCell) != nil else{
            fatalError("error")
        }
        
        let task = taskDAO.items[indexPath.row]
        
        task.completed = !task.completed
        
        taskDAO.addOrUpdate(task)
        
        tableView.reloadRows(at: [indexPath], with: .fade)
        
    }
    
    
    @IBAction func quickTaskAdd(_ sender: UITextField) {
        let task = Task(context: taskDAO.context)
        if let name = textQuickTask.text?.trimmingCharacters(in: .whitespacesAndNewlines),!name.isEmpty{
            task.name = name
        }else{
            task.name = "New task"
        }
        
        createTask(task)
        textQuickTask.text = ""
    }
    
    func deleteTask(_ indexPath:IndexPath){
        taskDAO.delete(taskDAO.items[indexPath.row])
        taskDAO.items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .top)
    }
    
    func createTask(_ task:Task){
        taskDAO.addOrUpdate(task)
        
        let indexPath = IndexPath(row: taskDAO.items.count-1, section: taskListSection)
        
        tableView.insertRows(at: [indexPath], with: .top)
    }
    
}

extension TaskListController: UISearchBarDelegate{
    
    func setupSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by name"
        searchController.searchBar.backgroundColor = .white
        
        definesPresentationContext = true
        
        //searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.searchBar.showsScopeBar = false
        
        if #available(iOS 11.0, *){
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        }else{
            tableView.tableHeaderView = searchController.searchBar
        }
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !(searchController.searchBar.text?.isEmpty)!{
            taskDAO.search(searchController.searchBar.text!)
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        taskDAO.getAll()
        tableView.reloadData()
    }
    
}
