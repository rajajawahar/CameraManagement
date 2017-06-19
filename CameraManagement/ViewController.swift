//
//  ViewController.swift
//  CameraManagement
//
//  Created by rajamohamed on 19/06/17.
//  Copyright © 2017 sedintechnologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var galleryBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var bitmapImagView: UIImageView!
    
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
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

