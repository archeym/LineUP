//
//  RequestLeaveViewController.swift
//  LineUP
//
//  Created by ardMac on 16/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

class RequestLeaveViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberOfDaysLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!

    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!{
        didSet{
            uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var chooseLeaveButton: UIButton!
    @IBOutlet weak var leaveLabel: UILabel!
    
    var selectedType : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if selectedType != nil {
            self.leaveLabel.text = selectedType
        }
    }

    @IBAction func chooseLeaveTypeButtonTapped(_ sender: Any) {
        
        if let initController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TypesOfLeavesViewController") as? TypesOfLeavesViewController{
            initController.delegate = self
            present(initController, animated: true, completion: nil)
        }
    }
    
    func uploadButtonTapped(){
        if let initController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController{
            navigationController?.pushViewController(initController, animated: true)
            
        }

    }
   

}

extension RequestLeaveViewController : LeaveTypeDelegate {
    func passLeaveType(_ selectedLeave: String) {
        self.selectedType = selectedLeave
    }
}