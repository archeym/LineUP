//
//  LoginViewController.swift
//  LineUP
//
//  Created by Arkadijs Makarenko on 16/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        handleLogin()
        print("login tapped")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
            loginButton.layer.borderWidth = 0.5
            loginButton.layer.cornerRadius = 5
        let tf = UITextField()
        tf.autocapitalizationType = .none
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func handleLogin(){
        guard let username = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        if username == "" || password == ""{
            warningPopUp(withTitle: "Input Error", withMessage: "Email or Password Can't Be Empty")
            return
        }
        
//        let username = emailTextField.text!
//        let password = passwordTextField.text!
        
        let url = URL(string: "http://192.168.1.147:9292/api/v1/sessions")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let params : [String:String] = [
            "email": username,
            "password" : password
        ]
        var data: Data?
        do{
            data = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }catch let error as NSError{
            print(error.localizedDescription)
            
        }
        urlRequest.httpBody = data
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let validError = error{
                print(validError.localizedDescription)
            }
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode == 403 {

                        self.warningPopUp(withTitle: "Input Error", withMessage: "Email or Password Can't Be Empty")
                }else if httpResponse.statusCode == 200 {
                    do{
                
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    guard let validJSON = jsonResponse as? [String:Any] else {return}
                    UserDefaults.standard.setValue(validJSON["private_token"], forKey: "AUTH_Token")
                    UserDefaults.standard.synchronize()
                    
                    
                    DispatchQueue.main.async {
                        self.goToMain()
                        self.clearTextFieldText()
                    }
                    print(jsonResponse)
                }catch let jsonError as NSError{
                    print(jsonError)
                    
                }
                }
            }
        }
        dataTask.resume()
    }
    
    
    func goToMain(){
        let initController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarController")
        present(initController, animated: true, completion: nil)
    }
    
    func clearTextFieldText(){
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
}//end

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imageViewTapped(){
        let initController = UIStoryboard(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier: "InfoViewController")
        present(initController, animated: true, completion: nil)
    }
}

extension UIViewController{
    func warningPopUp(withTitle title : String?, withMessage message : String?){
        DispatchQueue.main.async {
            
        
        let popUP = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        popUP.addAction(okButton)
        self.present(popUP, animated: true, completion: nil)
        }
    }
}
