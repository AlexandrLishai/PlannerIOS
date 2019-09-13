//
//  EditTaskInfoController.swift
//  Planner
//
//  Created by alex on 9/13/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class EditTaskInfoController: UIViewController {
    
    var taskInfo:String!
    var delegate:ActionResultDelegate!
    
    
    @IBOutlet weak var textTaskInfo: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let taskInfo = taskInfo{
            textTaskInfo.text = taskInfo
        }
        
        textTaskInfo.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickCancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func clickSaveButton(_ sender: UIBarButtonItem) {
        delegate.done(source: self, data: textTaskInfo.text)
        
        navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
