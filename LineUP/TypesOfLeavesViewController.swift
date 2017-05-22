//
//  TypesOfLeavesViewController.swift
//  LineUP
//
//  Created by ardMac on 16/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit
protocol LeaveTypeDelegate {
    func passLeaveType (_ selectedLeave: String, selectedLeaveIndex : Int)
}

class TypesOfLeavesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var typesOfLeaves = ["Annual", "Maternity", "Emergency", "Study", "Sick", "Non Paid"]
    var delegate : LeaveTypeDelegate? = nil
    var selectedLeave : String?
    var selectedLeaveIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}

extension TypesOfLeavesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typesOfLeaves.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = typesOfLeaves[indexPath.row]
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLeave = typesOfLeaves[indexPath.row]
        selectedLeaveIndex = indexPath.row
        delegate?.passLeaveType(selectedLeave!, selectedLeaveIndex: selectedLeaveIndex)
        dismiss(animated: true, completion: nil)
    }
    
}
