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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllLeave()
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
    
    
    func populateLeaves(_ array : [[String: Any]]){
        for leave in array {
            leaves.append(Leave(dict: leave))
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension AllRequestsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leaves.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RequestedTableViewCell.cellIdentifier) as? RequestedTableViewCell
            else {return UITableViewCell()}
        let newLeave = self.leaves[indexPath.row]
        cell.datesLabel.text = "\(newLeave.startDate) to \(newLeave.endDate)"
        cell.leaveLabel.text = newLeave.leaveType
        cell.numberOfDaysLabel.text = "\(String(newLeave.totalDays)) days"
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            
//            guard let player = filtered?[indexPath.row] else { return }
//            PlayerManager.shared.deletePlayer(player: player)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        }
    }
}
