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
    
    var placeName = [String]()
    var placeId = [String]()
    var selectedId: String?
    
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
     
            getData()
    }
    
    func getData(){
        let query = PFQuery(className: "places")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                let alert = self.makeAlert(title: "Error !", message: error?.localizedDescription ?? "Unrecognized error")
            } else {
                if objects != nil {
                    self.placeId.removeAll()
                    self.placeName.removeAll()
                    for object in objects! {
                        if let placeName = object.object(forKey: "placeName") {
                            if let placeId = object.objectId {
                                self.placeName.append(placeName as! String)
                                self.placeId.append(placeId)
                            }
                        }
                        
                        
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
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
    
    
        
    func makeAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        return alert
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedId = self.placeId[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destination = segue.destination as! DetailsVC
            destination.selectedId = self.selectedId
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = cell.defaultContentConfiguration()
        config.text = self.placeName[indexPath.row]
        
        cell.contentConfiguration = config
        return cell
    }
    
    
}



