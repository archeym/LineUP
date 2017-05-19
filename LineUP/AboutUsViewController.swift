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
    
    @IBOutlet weak var archie: UIImageView!
    
    @IBOutlet weak var ard: UIImageView!
    
    @IBOutlet weak var sofia: UIImageView!
    
    @IBOutlet weak var jamie: UIImageView!
    
    @IBOutlet weak var michella: UIImageView!

    @IBOutlet weak var lineupTeamLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineupTeamLabel.layer.borderWidth = 0.5
        lineupTeamLabel.layer.cornerRadius = 5
        
        archie.layer.masksToBounds = true
        archie.layer.cornerRadius = archie.frame.height/2
        archie.clipsToBounds = true
        archie.layer.borderWidth = 1
        archie.layer.borderColor = UIColor.brown.cgColor
        
        ard.layer.masksToBounds = true
        ard.layer.cornerRadius = ard.frame.height/2
        ard.clipsToBounds = true
        ard.layer.borderWidth = 1
        ard.layer.borderColor = UIColor.cyan.cgColor
        
        sofia.layer.masksToBounds = true
        sofia.layer.cornerRadius = ard.frame.height/2
        sofia.clipsToBounds = true
        sofia.layer.borderWidth = 1
        sofia.layer.borderColor = UIColor.red.cgColor
        
    }


}
