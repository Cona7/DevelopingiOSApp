//
//  ViewController.swift
//  FoodTracker
//
//  Created by Josip Glasovac on 05/10/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var raitingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    var meal: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self

        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text   = meal.name
            photoImageView.image = meal.photo
            raitingControl.rating = meal.rating
        }
    }

    @IBAction func cancel(_ sender: Any) {

        let isPresentingInAddMealMode = presentingViewController is UINavigationController

        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
}

extension MealViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if nameTextField.text != "" {
            navigationItem.title = textField.text

            textField.isEnabled = false

            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }

        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let raiting = raitingControl.rating

        meal = Meal(name: name, photo: photo, rating: raiting)
    }
}
