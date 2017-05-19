//
//  AboutUsViewController.swift
//  LineUP
//
//  Created by Arkadijs Makarenko on 18/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }

    @IBOutlet weak var lineupTeamLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineupTeamLabel.layer.borderWidth = 0.5
        lineupTeamLabel.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }


}
