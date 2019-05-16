//
//  CompanyModificationController + ImageDelegate.swift
//  Companies
//
//  Created by Hikaru Watanabe on 5/14/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

extension CompanyModificationController: ImageSelectDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc func imageDidTap(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let edittedImage = info[.editedImage] as? UIImage{
            companyModificationView.companyImageView.image = edittedImage
        }else if let originalImage = info[.originalImage] as? UIImage{
            companyModificationView.companyImageView.image = originalImage
        }
        setImageLayer()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
