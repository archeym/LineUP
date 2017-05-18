//
//  CompanyPolicyViewController.swift
//  LineUP
//
//  Created by Arkadijs Makarenko on 18/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

class CompanyPolicyViewController: UIViewController {

    @IBOutlet weak var lineUpLabel: UILabel!
    @IBOutlet weak var companyTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        companyTextView.layer.borderWidth = 0.5
        companyTextView.layer.cornerRadius = 10
        lineUpLabel.layer.borderWidth = 0.5
        lineUpLabel.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }

    @IBAction func backToContact(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
