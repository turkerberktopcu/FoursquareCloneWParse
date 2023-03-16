//
//  PlacesViewController.swift
//  FoursquareClone
//
//  Created by Türker Berk Topçu on 10.03.2023.
//

import UIKit
import Parse


class PlacesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Creating custom bar button
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "log-out.jpg"), for: .normal)
        button.addTarget(self, action: #selector(logOutClicked), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = barButtonItem
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
    }
    
    @objc func logOutClicked(){
        PFUser.logOutInBackground { error in
            if error != nil {
                let alert = self.makeAlert(title: "Error !", message: error!.localizedDescription)
                self.present(alert, animated: true)
            } else {
                self.performSegue(withIdentifier: "toOpeningVC", sender: nil)
            }
            
        }
    }
    
    @objc func addButtonClicked(){
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = cell.defaultContentConfiguration()
        config.text = "Test"
        
        cell.contentConfiguration = config
        return cell
    }
        
    func makeAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        return alert
    }


    
}


