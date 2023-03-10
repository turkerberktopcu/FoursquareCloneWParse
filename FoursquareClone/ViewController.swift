//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Türker Berk Topçu on 10.03.2023.
//




import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signInButton.layer.cornerRadius = 25
        signInButton.clipsToBounds = true
        signUpButton.layer.cornerRadius = 25
        signUpButton.clipsToBounds = true
    }

    
    
    
    @IBAction func signInClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" {
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { user, error in
                if error != nil {
                    let alert = self.makeAlert(title: "Error !", message: error!.localizedDescription)
                    self.present(alert,animated: true)
                } else {
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
                
            }
            
        } else {
            let alert = makeAlert(title: "Error !", message: "Username or Password Field is Empty !")
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    func makeAlert(title: String, message: String) -> UIAlertController {
        var alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        return alert
    }
    
    
}

