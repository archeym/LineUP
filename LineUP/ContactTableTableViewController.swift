//
//  ContactTableTableViewController.swift
//  LineUP
//
//  Created by Arkadijs Makarenko on 18/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit
import MessageUI

class ContactTableTableViewController: UITableViewController,MFMailComposeViewControllerDelegate, UIDocumentInteractionControllerDelegate  {
    @IBAction func aboutUsTapped(_ sender: Any) {
        let initController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AboutUsViewController")
        present(initController, animated: true, completion: nil)
        
    }
    @IBAction func companyPolicy(_ sender: Any) {
        let initController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CompanyPolicyViewController")
        present(initController, animated: true, completion: nil)
    }

    @IBAction func callToManager(_ sender: Any) {
        guard let url : NSURL = NSURL(string: "tel://+60189691864") else {return}//+60189691864
        UIApplication.shared.open(url as URL, options: [:])
       
    }
    
 
    @IBAction func callToHR(_ sender: Any) {
        guard let url : NSURL = NSURL(string: "tel://+601115984461") else {return}//+60189691864
        UIApplication.shared.open(url as URL, options: [:])
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row = \(indexPath.description)")
        
        
        if indexPath.section == 0 && indexPath.row == 0 {
            print("Send Us Suggestions")
            let mailCompose = emailFeedback()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailCompose, animated: true, completion: nil)
            }else{
                self.showMailError()
            }
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            print("Report a Problem")
            let mailCompose = emailReport()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailCompose, animated: true, completion: nil)
            }else{
                self.showMailError()
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func emailFeedback() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        //hr email
        mailComposerVC.setToRecipients(["archeym@me.com"])
        mailComposerVC.setSubject("Contact Manager")
        mailComposerVC.setMessageBody("Hello, \n\n\n\n\n\n\nThanks, have a nice day ...", isHTML: false)
        return mailComposerVC
    }
    func emailReport() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        //hr email
        mailComposerVC.setToRecipients(["archeym@me.com"])
        mailComposerVC.setSubject("Contact HR")
        mailComposerVC.setMessageBody("Hello, \n\n\n\n\n\n\nThanks, have a nice day ...", isHTML: false)
        return mailComposerVC
    }
    
    func showMailError() {
        let mailErrorAlert = UIAlertController(title: "Failed !", message: "Your iPhone couldn't send email.  Please check iPhone's email config and try again.", preferredStyle: .alert)
        self.present(mailErrorAlert, animated: true, completion: nil)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            mailErrorAlert.dismiss(animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch (result) {
            
        case MFMailComposeResult.cancelled:
            print("cancel mail")
            self.dismiss(animated: true, completion: nil)
            
        case MFMailComposeResult.sent:
            self.dismiss(animated: true, completion: nil)
            
        case MFMailComposeResult.failed:
            self.dismiss(animated: true, completion: {
                let emailErrorAlert = UIAlertController.init(title: "Failed",
                                                             message: "Unable to send email. Please check your email settings and try again.", preferredStyle: .alert)
                emailErrorAlert.addAction(UIAlertAction.init(title: "OK",
                                                             style: .default, handler: nil))
                self.present(emailErrorAlert, animated: true, completion: nil)
            })
        default:
            break
        }
    }
    

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}//end
