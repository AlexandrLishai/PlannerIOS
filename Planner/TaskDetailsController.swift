//
//  ViewController.swift
//  FirstApp
//
//  Created by alex on 8/6/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class TaskDetailsController: UIViewController, UITableViewDelegate, UITableViewDataSource, ActionResultDelegate {
    
    var task:Task!
    var delegate:ActionResultDelegate!
    
    var taskName:String?
    var taskInfo:String?
    var taskPriority:Priority?
    var taskCategory:Category?
    var taskDeadline:Date?
    
    var textTaskName:UITextField!
    var textTaskInfo:UITextView!
    
    let taskDAO = TaskDAOImpl.current
    
    private var dateFormatter = DateFormatter()
    
    @IBOutlet weak var tableViewTaskDetails: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        
        if let task = task{ // если объект не пустой (значит режим редактирования, а не создания новой задачи)
            taskName = task.name
            taskInfo = task.info
            taskPriority = task.priority
            taskCategory = task.category
            taskDeadline = task.deadline as! Date
        }
        
        //for i in 0...10000 {
        //    print(i)
        //}
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func clickCancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func clickSave(_ sender: UIBarButtonItem) {
        
        task.name = taskName
        task.category = taskCategory
        task.info = taskInfo
        
        
        delegate.done(source: self, data: task)
        
        navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskName", for: indexPath) as? TaskNameViewCell else{
                fatalError("error")
            }
            
            cell.textTaskName.text = task.name
            
            textTaskName = cell.textTaskName
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskCategory", for: indexPath) as? TaskCategoryViewCell else{
                fatalError("error")
            }
            
            var value:String
            
            if let name = taskCategory?.name{
                value = name
                cell.labelTaskCategory.textColor = UIColor.darkText
            }else{
                value = "not chosen"
                cell.labelTaskCategory.textColor = UIColor.lightGray
            }
            
            
            cell.labelTaskCategory.text = value
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskPriority", for: indexPath) as? TaskPriorityViewCell else{
                fatalError("error")
            }
            
            var value:String
            
            if let name = task.priority?.name{
                value = name
            }else{
                value = "not chosen"
            }
            
            
            cell.labelTaskPriority.text = value
            
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskDeadline", for: indexPath) as? TaskDeadlineViewCell else{
                fatalError("error")
            }
            
            var value:String
            
            if let name = task.deadline{
                value = dateFormatter.string(from: name as Date)
            }else{
                value = "not chosen"
            }
            
            
            cell.labelTaskDeadline.text = value
            
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskInfo", for: indexPath) as? TaskInfoViewCell else{
                fatalError("error")
            }
            
            cell.textTaskInfo.text = task.info
            
            textTaskInfo = cell.textTaskInfo
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Name"
        case 1:
            return "Category"
        case 2:
            return "Priority"
        case 3:
            return "Deadline"
        case 4:
            return "Info"
        default:
            return ""
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier! {
        case "selectCategory":
            
            guard let controller = segue.destination as? CategoryListController else{
                fatalError("error")
            }
            
            controller.title = "Choose category"
            controller.currentCategory = taskCategory
            controller.delegate = self            
        default:
            return
        }
        
        
    }
    
    // MARK: action
    
    func done(source: UIViewController, data: Any?) {
        if source is CategoryListController{
            if let selectedIndexPath = tableViewTaskDetails.indexPathForSelectedRow{
                taskCategory = data as! Category
                tableViewTaskDetails.reloadRows(at: [selectedIndexPath], with: .fade)
            }
        }
    }
    
    

}

