//
//  AllRequestsViewController.swift
//  LineUP
//
//  Created by Arkadijs Makarenko on 17/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

class AllRequestsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(RequestedTableViewCell.cellNib, forCellReuseIdentifier: RequestedTableViewCell.cellIdentifier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension AllRequestsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RequestedTableViewCell.cellIdentifier) as? RequestedTableViewCell
            else {return UITableViewCell()}
        return cell
    }
}
