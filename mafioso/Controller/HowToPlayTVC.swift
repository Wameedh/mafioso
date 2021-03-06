//
//  HowToPlayVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 10/31/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit


class HowToPlayTVC: UITableViewController {
    

    var selectedRow: Int = 0
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return howToPlayData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HowToPlayCell", for: indexPath)
        
        cell.textLabel?.text = howToPlayData[indexPath.row][0]
       // print(howToPlayData[0][0])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "howToPlayDetails", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "howToPlayDetails" {
            if let vc = segue.destination as? HowToPlayDetailsVC {
                vc.content = howToPlayData[selectedRow][1]
                
            }
            
        }
    }
    
    
    
}
