//
//  ViewController.swift
//  PhotoPickerDemo
//
//  Created by Rudolf Farkas on 01.08.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import UIKit

import MobileCoreServices // kUTTypeImage

class ViewController: UIViewController {

    var picker = UIImagePickerController()

    @IBOutlet weak var imageView: UIImageView!

    @IBAction func takePhoto(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            picker.allowsEditing = true
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        } else {
            print("*** no camera available")
        }
    }
    
    @IBAction func pickPhoto(_ sender: UIBarButtonItem) {
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [String(kUTTypeImage)]
        picker.allowsEditing = true
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        picker.popoverPresentationController?.barButtonItem = sender
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }

}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        print("   imagePickerController image sizes", originalImage.size, editedImage.size)
        imageView.contentMode = .scaleAspectFit
        imageView.image = editedImage
        dismiss(animated: true, completion: nil)
   }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

