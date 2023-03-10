//
//  SignUpViewController.swift
//  FoursquareClone
//
//  Created by Türker Berk Topçu on 10.03.2023.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signUpButton.layer.cornerRadius = 25
        signUpButton.clipsToBounds = true
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" {
            let user = PFUser()
            user.username = usernameText.text!
            user.password = passwordText.text!
            user.signUpInBackground { success, error in
                if error != nil {
                    let alert = self.makeAlert(title: "Error !", message: error!.localizedDescription)
                    self.present(alert, animated: true)
                } else {
                    self.performSegue(withIdentifier: "backToSignIn", sender: nil)
                }
            }
            
        } else {
            let alert = makeAlert(title: "Error !", message: "Email or Password is empty !")
            self.present(alert, animated: true)
        }
        
    }
    
    func makeAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        return alert
    }

}
