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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskDetails", for: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = task.name
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...10000 {
            print(i)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

