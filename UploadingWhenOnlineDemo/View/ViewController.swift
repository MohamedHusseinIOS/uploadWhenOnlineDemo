//
//  ViewController.swift
//  UploadingWhenOnlineDemo
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var openGalleryBtn: UIButton!
    
    let viewModel = ViewModel()
    let imagePicker = UIImagePickerController()
    var imageCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let counter = UserDefaults.standard.value(forKey: Constants.imageCounter.rawValue) as? Int else { return }
        imageCounter = counter
    }
    
    func openImagePicker(){
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }

    @IBAction func takePhotoTapped(_ sender: Any) {
        openImagePicker()
    }
    
    @IBAction func openGalleryTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(identifier: "GalleryViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        imageCounter = imageCounter + 1
        UserDefaults.standard.set(imageCounter, forKey: Constants.imageCounter.rawValue)
        UserDefaults.standard.synchronize()
        viewModel.saveImage(image: image, forKey: "photo\(imageCounter)")
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}

