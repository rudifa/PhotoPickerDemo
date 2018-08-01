//
//  ViewController.swift
//  PhotoPickerDemo
//
//  Created by Rudolf Farkas on 01.08.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import UIKit

import MobileCoreServices // kUTTypeImage

class ViewController: UIViewController, WrappedImagePickerDelegate {

    var wrapped: WrappedImagePicker!

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var takePhotoButton: UIBarButtonItem!

    @IBOutlet weak var pickPhotoButton: UIBarButtonItem!

    @IBAction func takePhoto(_ sender: UIBarButtonItem) {
        wrapped.takePhoto(edited: true)
    }

    @IBAction func pickPhoto(_ sender: UIBarButtonItem) {
        wrapped.pickPhoto(edited: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        wrapped = WrappedImagePicker(parent: self, imageView: imageView, delegate: self)
        takePhotoButton.isEnabled = wrapped.isCameraAvailable
    }

    func photoAvailable(image: UIImage) {
        print("   photoAvailable image.size=", image.size)
        // use image...
    }

}

protocol WrappedImagePickerDelegate {
    func photoAvailable(image: UIImage)
}

class WrappedImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    var parentVC: UIViewController!
    var imageView: UIImageView!
    var delegate: WrappedImagePickerDelegate!

    var picker = UIImagePickerController()

    init(parent: UIViewController, imageView: UIImageView, delegate: WrappedImagePickerDelegate) {
        self.parentVC = parent
        self.imageView = imageView
        self.delegate = delegate
        super.init()
        picker.delegate = self
    }

    var isCameraAvailable: Bool { get { return UIImagePickerController.isSourceTypeAvailable(.camera)}}

    func pickPhoto(edited: Bool) {
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [String(kUTTypeImage)]
        picker.allowsEditing = true
        picker.modalPresentationStyle = .popover
        parentVC.present(picker, animated: true, completion: nil)
//        parentVC.popoverPresentationController?.barButtonItem = sender
    }

    func takePhoto(edited: Bool) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            picker.allowsEditing = edited
            picker.modalPresentationStyle = .fullScreen
            parentVC.present(picker, animated: true, completion: nil)
        } else {
            print("*** no camera available")
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = editedImage
        delegate.photoAvailable(image: editedImage)
        parentVC.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parentVC.dismiss(animated: true, completion: nil)
    }

}


