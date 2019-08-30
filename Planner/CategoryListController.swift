//
//  CategoryListController.swift
//  Planner
//
//  Created by alex on 8/30/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class CategoryListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentCategory:Category!
    var currentCheckedIndexPath:IndexPath!
    private var list:[Category]!
    let categoryDAO = CategoryDAOImpl.current
    
    var delegate:ActionResultDelegate!

    @IBOutlet weak var tableViewCategoryList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = categoryDAO.getAll()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryListCell", for: indexPath) as? CategoryListViewCell else{
            fatalError("cell error")
        }
        
        let category = list[indexPath.row]
        
        if currentCategory != nil && currentCategory == category{
            cell.buttonCheck.setImage(UIImage(named: "check_green"), for: .normal)
            
            currentCheckedIndexPath = indexPath // save chosen index
            
        }else{
            cell.buttonCheck.setImage(UIImage(named: "check_gray"), for: .normal)
        }
        
        cell.labelCategoryName.text = category.name
        
        return cell
    }
    
    // delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete){
            categoryDAO.delete(list[indexPath.row])
            
            list.remove(at: indexPath.row)
            tableViewCategoryList.deleteRows(at: [indexPath], with: .top)
        }else if (editingStyle == .insert){
            // insert
        }
        
    }
    
    
    @IBAction func clickButtonCheck(_ sender: Any) {
        if let selectedIndexPath = tableViewCategoryList.indexPathForSelectedRow{
            
            currentCategory = list[selectedIndexPath.row]
            
            tableViewCategoryList.reloadRows(at: [currentCheckedIndexPath], with: .fade)
            
            tableViewCategoryList.reloadRows(at: [selectedIndexPath], with: .fade)
        }
        
    }
    
    
    @IBAction func clickButtonCancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func clickButtonSave(_ sender: UIBarButtonItem) {
        
        delegate.done(source: self, data: currentCategory)
        
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
