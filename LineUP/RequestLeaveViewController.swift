//
//  RequestLeaveViewController.swift
//  LineUP
//
//  Created by ardMac on 16/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit
import Firebase

class RequestLeaveViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var noOfDays: UILabel!
    @IBOutlet weak var typeOfLeave: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberOfDaysLabel: UILabel!
    
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var datesFromCalendar: UILabel!
   
    var user : User!
    let picker = UIImagePickerController()
    var photoImageView = UIImageView()
    var ref: DatabaseReference!
    var userId : Int = 0
    
    @IBOutlet weak var requestButton: UIButton!{
        didSet {
            requestButton.addTarget(self, action: #selector(requestButtonTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var uploadButton: UIButton!{
        didSet{
            uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var chooseLeaveButton: UIButton!
    @IBOutlet weak var chooseFromLibrary: UIButton!{
        didSet{
            chooseFromLibrary.addTarget(self, action: #selector(handleUploadPhoto), for: .touchUpInside)
        }
    }
    

    
    let formatter = DateFormatter()
    var testCalendar = Calendar.current
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = Calendar.current.timeZone
        let locale = Locale(identifier: "en_US_POSIX")
        formatter.locale = locale
        formatter.dateFormat = "yyyy MM dd"
        return formatter
    }()
    let displayDateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        return formatter
    }()
    var dates = [Date]()
    var currentUser : User!
    var selectedType : String?
    var selectedTypeIndex : Int = 0
    var imageURL : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.name.text = user.name
        self.numberOfDaysLabel.text = "\(dates.count)"
        self.datesFromCalendar.text = "\(displayDateFormatter.string(from: dates.first!)) - \(displayDateFormatter.string(from: dates.last!))"
        name.layer.cornerRadius = 5
        nameLabel.layer.cornerRadius = 5
        numberOfDaysLabel.layer.cornerRadius = 5
        noOfDays.layer.cornerRadius = 5
        requestButton.layer.cornerRadius = 5
        uploadButton.layer.cornerRadius = 5
        chooseLeaveButton.layer.cornerRadius = 5
        chooseFromLibrary.layer.cornerRadius = 5
        typeOfLeave.layer.cornerRadius = 5
        datesLabel.layer.cornerRadius = 5
        datesFromCalendar.layer.cornerRadius = 5
        getName()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedType != nil {
            self.chooseLeaveButton.setTitle(selectedType, for: .normal)
        }
        
        uploadPhotoToFirebase()
    }
    
    func handleBack(){
        
    }

    @IBAction func chooseLeaveTypeButtonTapped(_ sender: Any) {
        
        if let initController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TypesOfLeavesViewController") as? TypesOfLeavesViewController{
            initController.delegate = self
            present(initController, animated: true, completion: nil)
        }
    }
    
    func uploadButtonTapped(){
        if let initController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController{
            initController.delegate = self
            navigationController?.pushViewController(initController, animated: true)
            
        }

    }
    
    func goToAllRequests(){
        navigationController?.popViewController(animated: true)
    }
    
    func getName(){
        guard let validToken = UserDefaults.standard.string(forKey: "AUTH_Token") else { return }
        
        let url = URL(string: "http://192.168.1.48:9292/api/v1/users/\(userId)?private_token=\(validToken)")
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
                        
                        if let validJSON = jsonResponse as? [String:Any] {
                            if let dictionary = validJSON["user"] as? [String:Any]   {
                                self.currentUser = User(dict: dictionary)
                                DispatchQueue.main.async {
                                    self.currentUser = User(dict: dictionary)
                                    self.setupName()
                                }
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
    
    func setupName(){
        self.nameLabel.text = currentUser.name
    }
    
    
    func requestButtonTapped(){
        
        
        guard let validToken = UserDefaults.standard.string(forKey: "AUTH_Token") else { return }
        
        let url = URL(string: "http://192.168.1.48:9292/api/v1/leaves")
        var urlRequest = URLRequest(url: url!)
        let numberOfDays = dates.count
        
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let params : [String:Any] = [
            "start_date": "\(self.dates.first)",
            "end_date": "\(self.dates.last)",
            "total_days" : dates.count,
            "private_token" : validToken,
            "leave_type": selectedTypeIndex,
            "image" : imageURL
        ]
        
        var data: Data?
        do{
            data = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }catch let error as NSError{
            print(error.localizedDescription)
            
        }
        urlRequest.httpBody = data
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let validError = error{
                print(validError.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                print(httpResponse)
                
            }
        }
        requestSent()
        dataTask.resume()
        
        
    }
    
    func uploadPhotoToFirebase(){
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("images").child("\(imageName).jpg")
        
        if let profileImage = self.photoImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                if let imageUrl = metadata?.downloadURL()?.absoluteString{
                    self.imageURL = imageUrl
                }
            })
        }
    }
    
    func handleUploadPhoto(){
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
}//end

extension RequestLeaveViewController : LeaveTypeDelegate {
    
    func passLeaveType(_ selectedLeave: String, selectedLeaveIndex: Int) {
        self.selectedType = selectedLeave
        self.selectedTypeIndex = selectedLeaveIndex
    }
    func backToAllRequests(){
        navigationController?.popViewController(animated: true)
    }
    func requestSent(){
        // the alert view
        let alert = UIAlertController(title: "Request Sent", message: "Check Request Status in Requests", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds, code with delay
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
            self.backToAllRequests()
        }
    }
}

extension RequestLeaveViewController : PhotoDelegate {
    func passPhotoUrl(_ photoUrl: String) {
        self.imageURL = photoUrl
    }
}

extension RequestLeaveViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("User canceled out of picker")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage
        {
            selectedImageFromPicker = editedImage
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker
        {
            photoImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}
