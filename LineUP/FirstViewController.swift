//
//  FirstViewController.swift
//  LineUP
//
//  Created by Arkadijs Makarenko on 16/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var supervisorLabel: UILabel!
    
    
    
    
    @IBOutlet weak var annualLeaveLabel: UILabel!
    @IBOutlet weak var maternityLeaveLabel: UILabel!
    
    @IBOutlet weak var emergencyLeaveLabel: UILabel!
    @IBOutlet weak var studyLeaveLabel: UILabel!
    
    @IBOutlet weak var sickLeaveLabel: UILabel!
    
    @IBOutlet weak var nonpaidLeaveLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    
    var name : String?
    var currentUser : User!
    var currentUserManager : Manager!
    var userId : Int = 0
    
    @IBAction func logoutBarButton(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "AUTH_Token")
        defaults.synchronize()
        let initController = UIStoryboard(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
        present(initController, animated: true, completion: nil)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setupAPI()
    }
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var requestView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAPI()
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.brown.cgColor
        //infoView.layer.borderWidth = 0.5
        infoView.layer.cornerRadius = 10
        //requestView.layer.borderWidth = 0.5
        requestView.layer.cornerRadius = 10
        
    }

    func setupAPI(){
        guard let validToken = UserDefaults.standard.string(forKey: "AUTH_Token") else { return }
        
        let url = URL(string: "http://192.168.1.48:9292/api/v1/users/\(userId)?private_token=\(validToken)")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        if let validJSON = jsonResponse as? [String:Any] {
                            if let dictionary = validJSON["user"] as? [String:Any]   {
                                    self.currentUser = User(dict: dictionary)
                                DispatchQueue.main.async {
                                    self.currentUser = User(dict: dictionary)
                                    self.setupProfile()
                                }
                            }
                            if let dictionary2 = validJSON["manager_name"] as? [String: Any] {
                                self.currentUserManager = Manager(dictB: dictionary2)
                            }
                        }
                        
                    } catch let jsonError as NSError {
                        print(jsonError)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func setupProfile(){
        self.nameLabel.text = self.currentUser.name
        self.emailLabel.text = self.currentUser.email
        self.departmentLabel.text = self.currentUser.department
        self.addressLabel.text = self.currentUser.address
        self.supervisorLabel.text = self.currentUserManager.supervisor
        self.phoneLabel.text = self.currentUser.phoneNumber
        self.positionLabel.text = self.currentUser.position
        
        self.annualLeaveLabel.text = String(self.currentUser.annualLeaves)
        self.maternityLeaveLabel.text = String(self.currentUser.maternityLeave)
        self.sickLeaveLabel.text = String(self.currentUser.sickLeaves)
        self.emergencyLeaveLabel.text = String(self.currentUser.emergencyLeave)
        self.studyLeaveLabel.text = String(self.currentUser.studyLeave)
        self.nonpaidLeaveLabel.text = String(self.currentUser.nonPaid)
        //self.profileImageView.image = UIImage(self.currentUser.profilePhoto)
        
    }
}

