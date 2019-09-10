//
//  PriorityListController.swift
//  Planner
//
//  Created by alex on 8/30/19.
//  Copyright © 2019 alex. All rights reserved.
//


import Foundation
import UIKit

class PriorityListController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var currentDictionary:Dictionary<PriorityDAOImpl>!
    
    @IBOutlet weak var tableViewDictionaryList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentDictionary.dictionaryList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    
    // delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete){
            currentDictionary.currentDAO.delete(currentDictionary.dictionaryList[indexPath.row])
            
            currentDictionary.dictionaryList.remove(at: indexPath.row)
            tableViewDictionaryList.deleteRows(at: [indexPath], with: .top)
        }else if (editingStyle == .insert){
            // insert
        }
        
    }
    
    
    @IBAction func clickButtonCheck(_ sender: UIButton) {
        
        let viewPosition = sender.convert(CGPoint.zero, to: tableViewDictionaryList)
        let indexPath = tableViewDictionaryList.indexPathForRow(at: viewPosition)!
        
        let item = currentDictionary.dictionaryList[indexPath.row]
        
        if indexPath != currentDictionary.currentCheckedIndexPath{
            currentDictionary.currentItem = item
            
            if let currentCheckedIndexPath = currentDictionary.currentCheckedIndexPath{
                tableViewDictionaryList.reloadRows(at: [currentCheckedIndexPath], with: .fade)
            }
            
            currentDictionary.currentCheckedIndexPath = indexPath
            
        }else{
            currentDictionary.currentCheckedIndexPath = nil
            currentDictionary.currentItem = nil
        }
        
        tableViewDictionaryList.reloadRows(at: [indexPath], with: .fade)
        
    }
    
    
    @IBAction func clickButtonCancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func clickButtonSave(_ sender: UIBarButtonItem) {
        
        currentDictionary.delegate.done(source: self, data: currentDictionary.currentItem)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dictionaryListCell", for: indexPath) as? DictionaryListViewCell else{
            fatalError("cell error")
        }
        
        let item = currentDictionary.dictionaryList[indexPath.row]
        
        if currentDictionary.currentItem != nil && currentDictionary.currentItem == item{
            cell.buttonCheck.setImage(UIImage(named: "check_green"), for: .normal)
            
            currentDictionary.currentCheckedIndexPath = indexPath // save chosen index
            
        }else{
            cell.buttonCheck.setImage(UIImage(named: "check_gray"), for: .normal)
        }
        
        cell.labelDictionaryName.text = currentDictionary.currentDAO.getName(item)
        
        return cell
    }
    
}
