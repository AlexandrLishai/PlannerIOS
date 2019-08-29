//
//  ViewController.swift
//  FirstApp
//
//  Created by alex on 8/6/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class TaskDetailsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var task:Task!
    var delegate:ActionResultDelegate!
    
    var textTaskName:UITextField!
    
    private var dateFormatter = DateFormatter()
    
    
    @IBAction func clickCancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func clickSave(_ sender: UIBarButtonItem) {
        task.name = textTaskName.text
        
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
            
            if let name = task.category?.name{
                value = name
            }else{
                value = "not chosen"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        
        //for i in 0...10000 {
        //    print(i)
        //}
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

