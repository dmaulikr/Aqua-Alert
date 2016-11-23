//
//  SettingsTableViewController.swift
//  H2O
//
//  Created by Arpit Hamirwasia on 2016-11-22.
//  Copyright © 2016 Arpit. All rights reserved.
//


import UIKit
import PMAlertController

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationItem.setHidesBackButton(true, animated: false)
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
            case 0,2:
                return 1
            case 1:
                return 2
            default:
                return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 && indexPath.row == 0 {
            return nil
        }
        else if indexPath.section == 2 {
            return nil
        }
        
        return indexPath
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath is: \(indexPath)")
        let cell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        switch cell.reuseIdentifier! {
            case "changeCell":
                performSegue(withIdentifier: "showInitialFormSegue", sender: nil)
                break
            case "freqCell":
                let choices = PMAlertController(title: "Choose an interval", description: "", image: nil, style: .walkthrough)
                choices.gravityDismissAnimation = false
                choices.alertTitle.textColor = .blue
                let minutes = [15,30,45]
            
                for i in minutes {
                    let alertAction = PMAlertAction(title: "Every " + String(i) + " minutes", style: .default, action: { (result) in
                        print("i: \(i)")
                    })
                    choices.addAction(alertAction)
                }
            
                let hours = [1,2,3,4]
            
                for i in hours {
                    var time = ""
                    if i == 1 {
                        time = " hour"
                    }
                    else {
                        time = " hours"
                    }
                    
                    let alertAction = PMAlertAction(title: "Every " + String(i) + time, style: .default, action: { (result) in
                        print("i: \(i)")
                    })
                    choices.addAction(alertAction)
                }
                
                self.present(choices, animated: true, completion: nil)
                break
            default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        if segue.identifier == "showInitialFormSegue" {
           let destinationVC = segue.destination as? InitialFormViewController
           destinationVC?.cameFromSettings = true
        }
    }
}
