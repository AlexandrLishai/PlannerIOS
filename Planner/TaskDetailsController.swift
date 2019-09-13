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
    var taskDeadline:NSDate?
    
    let taskNameSection = 0
    let taskCategorySection = 1
    let taskPrioritySection = 2
    let taskDeadlineSection = 3
    let taskInfoSection = 4
    
    let taskDAO = TaskDAOImpl.current
    
    private var dateFormatter = DateFormatter()
    
    @IBOutlet weak var tableViewTaskDetails: UITableView!
    
    
    @IBOutlet weak var buttonDeleteTask: UIButton!
    
    @IBOutlet weak var buttonCompleteTask: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        
        if let task = task{ // если объект не пустой (значит режим редактирования, а не создания новой задачи)
            taskName = task.name
            taskInfo = task.info
            taskPriority = task.priority
            taskCategory = task.category
            taskDeadline = task.deadline
        }
        
        buttonDeleteTask.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)        
        buttonCompleteTask.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
                
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: button actions 
    
    
    @IBAction func clickDeleteTaskButton(_ sender: UIButton) {
        let dialogMessage = UIAlertController(title: "Warning", message: "Delete task?" , preferredStyle: .actionSheet)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in
            self.performSegue(withIdentifier: "DeleteTaskFromDetails", sender: self) })
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: {(action)  -> Void in})
        
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func clickCancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func clickSave(_ sender: UIBarButtonItem) {
        
        task.name = taskName
        task.category = taskCategory
        task.priority = taskPriority
        task.deadline = taskDeadline
        task.info = taskInfo
        
        
        delegate.done(source: self, data: task)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func clickButtonClear(_ sender: AreaTabButton) {
        taskDeadline = nil
        
        tableViewTaskDetails.reloadRows(at: [IndexPath(row: 0, section: taskDeadlineSection)], with: .fade)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case taskInfoSection:
            return 120
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case taskNameSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskName", for: indexPath) as? TaskNameViewCell else{
                fatalError("error")
            }
            
            cell.textTaskName.text = taskName
            
            return cell
        case taskCategorySection:
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
            
        case taskPrioritySection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskPriority", for: indexPath) as? TaskPriorityViewCell else{
                fatalError("error")
            }
            
            var value:String
            
            if let name = taskPriority?.name{
                value = name
            }else{
                value = "not chosen"
            }
            
            
            cell.labelTaskPriority.text = value
            
            return cell
            
        case taskDeadlineSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskDeadline", for: indexPath) as? TaskDeadlineViewCell else{
                fatalError("error")
            }
            
            var value:String
            
            if let name = taskDeadline{
                value = dateFormatter.string(from: name as Date)
                cell.buttonClearDeadline.isHidden = false
            }else{
                value = "not chosen"
                cell.buttonClearDeadline.isHidden = true
            }
            
            
            cell.labelTaskDeadline.text = value
            
            
            return cell
            
        case taskInfoSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskInfo", for: indexPath) as? TaskInfoViewCell else{
                fatalError("error")
            }
            
            
            cell.textTaskInfo.text = taskInfo
            
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case taskNameSection:
            return "Name"
        case taskCategorySection:
            return "Category"
        case taskPrioritySection:
            return "Priority"
        case taskDeadlineSection:
            return "Deadline"
        case taskInfoSection:
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
            
            let title = "Choose category"
            let dictionary = Dictionary<CategoryDAOImpl>()
            dictionary.currentItem = taskCategory
            dictionary.currentDAO = CategoryDAOImpl.current
            dictionary.dictionaryList = CategoryDAOImpl.current.getAll()
            dictionary.delegate = self
            let controller = segue.destination as? CategoryListController
            controller?.title = title
            controller?.currentDictionary = dictionary
            
            
            
        case "selectPriority":
            let title = "Choose priority"
            let dictionary = Dictionary<PriorityDAOImpl>()
            dictionary.currentItem = taskPriority
            dictionary.currentDAO = PriorityDAOImpl.current
            dictionary.dictionaryList = PriorityDAOImpl.current.getAll()
            dictionary.delegate = self
            let controller = segue.destination as? PriorityListController
            controller?.title = title
            controller?.currentDictionary = dictionary
            
        case "EditTaskInfo":
            if let controller = segue.destination as? EditTaskInfoController{
                controller.taskInfo = taskInfo
                controller.delegate = self
            }
        default:
            return
        }
        
        
    }
    
    // MARK: action
    
    func done(source: UIViewController, data: Any?) {
        
        if let selectedIndexPath = tableViewTaskDetails.indexPathForSelectedRow{
            if source is CategoryListController{
                taskCategory = data as? Category
            }
            if source is PriorityListController{
                taskPriority = data as? Priority
            }
            
            tableViewTaskDetails.reloadRows(at: [selectedIndexPath], with: .fade)
        }
        
        if source is EditTaskInfoController{
            taskInfo = data as? String
            tableViewTaskDetails.reloadRows(at: [IndexPath(row: 0, section: taskInfoSection)], with: .fade)
        }
        
        
    }
    
    

}

