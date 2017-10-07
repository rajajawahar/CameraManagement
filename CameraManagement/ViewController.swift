//
//  ViewController.swift
//  CameraManagement
//
//  Created by rajamohamed on 19/06/17.
//  Copyright © 2017 sedintechnologies. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var galleryBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var bitmapImagView: UIImageView!
    var leagal_name  : String = "namee"
    var  preferred_name : String  = "preffered name"
    var  age  : String  = "16"
    var  position  : String  = "position"
    var  mobile  : String  = "7894561230"
    var  lbp_number  : String = "lbp number"
    var  has_agreement  : String = "true"
    var  agreement_type  : String  = "aggrement type"
    var  has_eligibility  : String = "true"
    var  tax_declaration : String  = "tax declaration"
    var  street_address  : String = "street address"
    var  suburb  : String = "suburb"
    var city : String  = "city"
    var postcode  : String = "postcode"
    var phone_number  : String = "1234567890"
    var payment_method : String  = "payment cash"
    var start_date : String  = "May 5,2017"
    var leave_entitlement_date : String  = "May 5,2017"
    var  termination_date : String  = "May 5,2017"
    var isArchived : String  = "false"
    var licenecedClass  : String = "sample,test ram"
    var travelRate  : String  = "rate"
    var adminRate  : String  = "rate"
    var labourRate : String  = ""
    var staffEmail : String  = "raja@gmail.com"
    
var picker:UIImagePickerController?=UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker?.delegate=self
        cameraBtn.addTarget(self, action: #selector(self.openCamera), for: .touchUpInside)
        galleryBtn.addTarget(self, action:#selector(self.openGallery), for: .touchUpInside)

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func callMe(_ sender: Any) {
        openGallery()
    }
   
    
    
    func openGallery()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        
        picker?.allowsEditing = false
        picker?.sourceType = .photoLibrary
        picker?.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker?.modalPresentationStyle = .popover
        present(picker!, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerControllerSourceType.camera
            picker!.cameraCaptureMode = .photo
            present(picker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            bitmapImagView.image = image
            netwrokCall(image: image,assetPath : info[UIImagePickerControllerReferenceURL] as! NSURL)
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func netwrokCall(image : UIImage , assetPath : NSURL){
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        let header : [String: String] = ["Authorization" : "authorisaction"]
        
        let params : [String:Any] = ["param" : "param"]

        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "key used",fileName: assetPath.lastPathComponent!, mimeType: "image/jpg")
            multipartFormData.append(imgData, withName: "worker_record[signature]",fileName: assetPath.lastPathComponent!, mimeType: "image/jpg")
            for (key, value) in params {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        },
                         to:"URl",method: .post,headers :header )
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.result.value ?? "Result Success")
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
}

