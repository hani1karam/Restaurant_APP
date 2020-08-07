//
//  RegisterVC.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/1/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import Alamofire
import Photos
class RegisterVC: BaseViewController {
    static func instance () -> RegisterVC {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var EmaiTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var ButtonImage: UIButton!
    
    
    var localPath: String?
    let debuggingTag = "RegitserVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 3
        
    }
    @IBAction func RegisterButton(_ sender: Any) {
        let urlReq = register
        guard  let data = profileImageView.image?.jpegData(compressionQuality: 0.2) else {return}
        let _: NSData = profileImageView.image!.pngData()! as NSData
        let imageobj = profileImageView.image!
        _ = imageobj.pngData()
        let params = [
            "name": NameTextField.text ?? "",
            "phone": PhoneTextField.text ?? "",
            "email": EmaiTextField.text ?? "",
            "password": PasswordTextField.text ?? ""]
        showLoading()
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: "image",fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in params {// this will loop the 'parameters' value, you can comment this if not needed
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
                
            }
        },
                         to:urlReq, method: .post)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    
                })
                upload.responseJSON { response in
                    switch response.result {
                    case .success :
                        do {
                            
                            let responseModel = try JSONDecoder().decode(RegisterModel.self, from: response.data!)
                            self.HideLoading()
                            self.showToast(message: responseModel.message ?? "")
                            if responseModel.message == "تم التسجيل بنجاح"
                            {
                                let Home = MenuTabBar.instance()
                                Home.modalPresentationStyle = .fullScreen
                                self.present(Home, animated: true, completion: nil)
                                
                                
                            }
                            
                        } catch (let error) {
                            print(error.localizedDescription)
                            //   completion(nil , error)
                        }
                    case .failure(let error) :
                        self.HideLoading()
                        //completion(nil , error)
                        self.showToast(message: error.localizedDescription)
                        
                    }
                    // completion("success")
                    print(response)
                }
            case .failure(let encodingError):
                
                
                print(encodingError)
                //  completion("failed")
            }
        }
        
        
        
    }
    
    
    @IBAction func BackToLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addbutton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization { (status) in
                DispatchQueue.main.async {
                    
                    switch status {
                    case .authorized:
                        let myPickercontroller = UIImagePickerController()
                        myPickercontroller.delegate = self
                        myPickercontroller.sourceType = .photoLibrary
                        self.present(myPickercontroller, animated: true)
                        
                    case .notDetermined:
                        if status == PHAuthorizationStatus.authorized {
                            let myPickercontroller = UIImagePickerController()
                            myPickercontroller.delegate = self
                            myPickercontroller.sourceType = .photoLibrary
                            
                            self.present(myPickercontroller, animated: true)
                        }
                        
                    case .restricted:
                        let alert = UIAlertController(title: "photo Libarary Restricted ", message: "photo libarary access restricted ", preferredStyle: .alert)
                        let okaction = UIAlertAction(title: "ok", style: .default)
                        alert.addAction(okaction)
                        self.present(alert, animated: true)
                        
                    case .denied:
                        let alert = UIAlertController(title: "photo Libarary denied ", message: "photo libarary access denied ", preferredStyle: .alert)
                        let okaction = UIAlertAction(title: "go to setting", style: .default) {
                            (action) in
                            
                            DispatchQueue.main.async {
                                let url = URL(string: UIApplication.openSettingsURLString)!
                                UIApplication.shared.open(url, options: [:])
                                
                            }
                        }
                        
                        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
                        alert.addAction(okaction)
                        alert.addAction(cancelAction)
                        
                        self.present(alert, animated: true)
                        
                    @unknown default:
                        fatalError()
                    }
                }
            }
            
        }
        
        
        
    }
}
extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        
        let documentDirectory: NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        
        let imageName = "temp"
        let imagePath = documentDirectory.appendingPathComponent(imageName)
        print(debuggingTag, "image path : \(imagePath)")
        
        
        
        
        localPath = imagePath
        print(debuggingTag, "local path: \(String(describing: localPath))")
        
        if let image = info[.editedImage] as? UIImage {
            self.profileImageView.image = image
            self.profileImageView.image = image
            ButtonImage.isHidden = true
            
            
            if let data = image.jpegData(compressionQuality: 80)
            {
                do {
                    try data.write(to: URL(fileURLWithPath: imagePath), options: .atomic)
                } catch let error {
                    print(error)
                }
            }
            
            
        } else if let image = info[.originalImage] as? UIImage {
            self.profileImageView.image = image
            
            if let data = image.jpegData(compressionQuality: 80)
            {
                do {
                    try data.write(to: URL(fileURLWithPath: imagePath), options: .atomic)
                } catch let error {
                    print(error)
                }
            }
            
            
        }
        
        ButtonImage.isHidden = true
        
        
        
        dismiss(animated: true)
    }
    
    func imGWPickerControllerDidCancek(_ picker: UIImagePickerController)
    {
        dismiss(animated: true)
        ButtonImage.isHidden = true
    }
    
}



