//
//  AddPlaceVC.swift
//  FoursquareClone
//
//  Created by Türker Berk Topçu on 13.03.2023.
//

import UIKit
import Parse

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailsText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let navigationController = UINavigationController()
        self.imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func nextClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapVC" {
            if let navDest = segue.destination as? UINavigationController, let destination = navDest.topViewController as? MapVC{
                let place = Places(placeName: self.nameText.text, placeType: self.typeText.text, placeDetails: self.detailsText.text, imageData: self.imageView.image?.jpegData(compressionQuality: 0.7))
                destination.placeToSave = place
            }
        }
    }
    
}
