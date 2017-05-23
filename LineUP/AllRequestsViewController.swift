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
    
    var leaves = [Leave]()
    var userId : Int?
    var notification = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        

    }
    func refreshTable(){
        leaves.removeAll()
        getAllLeave()
        tableView.refreshControl?.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leaves.removeAll()
        getAllLeave()
        updateBadge()
        tableView.tableFooterView = UIView()
        //leaves.sort(by: { $1.leaveId > $0.leaveId })
    }
    
    func getAllLeave(){
        
        guard let validToken = UserDefaults.standard.string(forKey: "AUTH_Token") else { return }
        let url = URL(string: "http://192.168.1.48:9292/api/v1/users/\(userId)?private_token=\(validToken)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
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
                           
                            if let dictionary = validJSON["user_leave"] as? [[String:Any]]{
                                self.populateLeaves(dictionary)
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
    
    func deleteARequest(leaveId : Int){
        
        guard let validToken = UserDefaults.standard.string(forKey: "AUTH_Token") else { return }
        let url = URL(string: "http://192.168.1.48:9292/api/v1/leaves/\(leaveId)?private_token=\(validToken)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let err = error as NSError?{
                print(err.localizedDescription)
                return
            }
        }
        dataTask.resume()
    }
    
    func populateLeaves(_ array : [[String: Any]]){
        for leave in array {
            
            leaves.append(Leave(dict: leave))
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func updateBadge(){
        if notification != 0 {
            tabBarItem.badgeValue = "\(notification)"
        }
    }
}

extension AllRequestsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leaves.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RequestedTableViewCell.cellIdentifier) as? RequestedTableViewCell
            else {return UITableViewCell()}
        let newLeave = self.leaves[indexPath.row]
        cell.datesLabel.text = "\(newLeave.startDate) to \(newLeave.endDate)"
        cell.leaveLabel.text = newLeave.leaveType
        cell.numberOfDaysLabel.text = "\(String(newLeave.totalDays)) days"
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        switch newLeave.status {
        case "Pending":
            cell.statusImageView.image = #imageLiteral(resourceName: "wait")
        case "Approved":
            cell.statusImageView.image = #imageLiteral(resourceName: "yes")
            cell.isUserInteractionEnabled = false
        case"Rejected":
            cell.statusImageView.image = #imageLiteral(resourceName: "no")
            cell.isUserInteractionEnabled = false
        default:
            break;
        }
        return cell
    }
    @objc func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    func displayAlert(){
        let alert: UIAlertController = UIAlertController(title: "Delete Request", message: "Are You Sure?", preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        //        let resetAction: UIAlertAction = UIAlertAction(title: "Reset", style: .destructive)
        let resetAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(alert: UIAlertAction) in

        })
        
        alert.addAction(cancelAction)
        alert.addAction(resetAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            
            let alert: UIAlertController = UIAlertController(title: "Delete Request", message: "Are You Sure?", preferredStyle: .alert)
            
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)

        
            let resetAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(alert: UIAlertAction) in
                let leaveID = self.leaves[indexPath.row].leaveId
                self.deleteARequest(leaveId: leaveID)
                self.leaves.remove(at: indexPath.row)
                tableView.reloadData()
            })
            
            alert.addAction(cancelAction)
            alert.addAction(resetAction)
            self.present(alert, animated: true, completion: nil)
            tableView.reloadData()
            
        }
    }
}
