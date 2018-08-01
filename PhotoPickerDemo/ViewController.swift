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

    var wrapped: WrappedImagePicker!

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var takePhotoButton: UIBarButtonItem!

    @IBOutlet weak var pickPhotoButton: UIBarButtonItem!

    @IBAction func takePhoto(_ sender: UIBarButtonItem) {
        wrapped.takePhoto()
    }

    @IBAction func pickPhoto(_ sender: UIBarButtonItem) {
        wrapped.pickPhoto()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        wrapped = WrappedImagePicker(parent: self, imageView: imageView)
        takePhotoButton.isEnabled = wrapped.isCameraAvailable
    }

}


class WrappedImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    var parentVC: UIViewController!
    var imageView: UIImageView!

    var picker = UIImagePickerController()

    init(parent: UIViewController, imageView: UIImageView) {
        self.parentVC = parent
        self.imageView = imageView
        super.init()
        picker.delegate = self
    }

    var isCameraAvailable: Bool { get { return UIImagePickerController.isSourceTypeAvailable(.camera)}}

    func pickPhoto() {
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [String(kUTTypeImage)]
        picker.allowsEditing = true
        picker.modalPresentationStyle = .popover
        parentVC.present(picker, animated: true, completion: nil)
//        parentVC.popoverPresentationController?.barButtonItem = sender
    }

    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            picker.allowsEditing = true
            picker.modalPresentationStyle = .fullScreen
            parentVC.present(picker, animated: true, completion: nil)
        } else {
            print("*** no camera available")
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        print("   imagePickerController image sizes", originalImage.size, editedImage.size)
        imageView.contentMode = .scaleAspectFit
        imageView.image = editedImage

        // use edited or original image here!

        parentVC.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parentVC.dismiss(animated: true, completion: nil)
    }

}


