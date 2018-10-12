//
//  ViewController.swift
//  FoodTracker
//
//  Created by Josip Glasovac on 05/10/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var raitingControl: RatingControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
    }
}

extension MealViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}

extension MealViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func selectPhotoFromLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()

        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self

        present(imagePickerController, animated: true, completion: nil)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        photoImageView.image = selectedImage

        dismiss(animated: true, completion: nil)
    }
}
