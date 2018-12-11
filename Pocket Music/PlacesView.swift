//
//  PlacesView.swift
//  Pocket Music
//
//  Created by Hai Duong on 12/10/18.
//  Copyright © 2018 Hai Duong. All rights reserved.
//

import UIKit
import GooglePlaces

class PlacesView: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var likelyPlaces: [GMSPlace] = []
    var selectedPlace: GMSPlace?
    
    let cellReuseIdentifier = "cell";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register the table view cell class and its reuse id.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller provides delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }
    
    // Pass the selected place to the new view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToMain" {
            if let nextViewController = segue.destination as? MapView {
                nextViewController.selectedPlace = selectedPlace
            }
        }
    }

}

// Respond when a user selects a place.
extension PlacesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlace = likelyPlaces[indexPath.row]
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
}

// Populate the table with the list of most likely places.
extension PlacesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likelyPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let collectionItem = likelyPlaces[indexPath.row]
        
        cell.textLabel?.text = collectionItem.name
        
        return cell
    }
    
    // Adjust cell height to only show the first five items in the table
    // (scrolling is disabled in IB).
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.size.height/5
    }
    
    // Make table rows display at proper height if there are less than 5 items.
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == tableView.numberOfSections - 1) {
            return 1
        }
        return 0
    }
}
