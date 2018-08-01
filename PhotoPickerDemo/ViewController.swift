//
//  ViewController.swift
//  PhotoPickerDemo
//
//  Created by Rudolf Farkas on 01.08.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import UIKit

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

