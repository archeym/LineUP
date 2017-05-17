//
//  LoginViewController.swift
//  LineUP
//
//  Created by Arkadijs Makarenko on 16/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let initController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarController")
        present(initController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
       
            loginButton.layer.borderWidth = 0.5
            loginButton.layer.cornerRadius = 5
        
    }

    
    
}//end

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imageViewTapped(){
        let initController = UIStoryboard(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier: "InfoViewController")
        present(initController, animated: true, completion: nil)
    }
}
