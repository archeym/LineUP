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
    @IBOutlet weak var paternityLeaveLabel: UILabel!
    @IBOutlet weak var emergencyLeaveLabel: UILabel!
    @IBOutlet weak var studyLeaveLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    var name : String?
    var selectedUser = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let validToken = UserDefaults.standard.string(forKey: "AUTH_TOKEN") else { return }
        
        let url = URL(string: "http://192.168.1.147:9292/api/v1/users?private_token=\(validToken)")
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
                        
                        
                        guard let validJSON = jsonResponse as? [[String:Any]] else { return }
                        
                        print(validJSON)
                        
                        
                    } catch let jsonError as NSError {
                        print(jsonError)
                    }
                    
                }
            }
            
        }
        dataTask.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

