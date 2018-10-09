//
//  ViewController.swift
//  FoodTracker
//
//  Created by Josip Glasovac on 05/10/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameTextLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        nameTextLabel.text = "Deafault Text"
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameTextLabel.text = nameTextField.text
    }
}
