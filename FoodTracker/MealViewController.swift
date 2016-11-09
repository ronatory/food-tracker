//
//  MealViewController.swift
//  FoodTracker
//
//  Created by ronatory on 09.11.16.
//  Copyright © 2016 ronatory. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  // MARK: Properties
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  /*
   This value is either passed by 'MealTableViewController' in 
   'prepareForSegue(_:sender:)'
   or constructed as part of adding a new meal.
   */
  var meal: Meal?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Handle the text field's user input through delegate callbacks.
    nameTextField.delegate = self
    
    // Set up views if editing an existing Meal
    if let meal = meal {
      navigationItem.title =  meal.name
      nameTextField.text   =  meal.name
      photoImageView.image =  meal.photo
      ratingControl.rating =  meal.rating
    }
    
    // Enable the Save button only if the text field has a valid Meal name
    checkValidMealName()
  }
  
  // MARK: UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Hide keyboard
    textField.resignFirstResponder()
    // indicates that the text field should respond to the user pressing the Return key by dismissing the keyboard.
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    checkValidMealName()
    // set title of the scene to the textField text
    navigationItem.title = textField.text
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // Disable the save button while editing
    saveButton.isEnabled = false
  }
  
  func checkValidMealName() {
    // Disable the save button if the text field is empty
    let text = nameTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
  }
  
  // MARK: UIImagePickerControllerDelegate
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    // Dismiss the picker if the user canceled
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    // The info dictionary contains multiple representations of the image and this uses the original
    let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    
    // Set photoImageView to display the selected image
    photoImageView.image = selectedImage
    
    // Dismiss the picker
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: Navigation
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    
    // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways
    let isPresentingInAddMealMode = presentingViewController is UINavigationController
    
    if isPresentingInAddMealMode {
      dismiss(animated: true, completion: nil)
    } else {
      // gets executed when the meal scene was pushed onto the navigation stack on top of the meal list scene
      // the code within the else clause executes a method called popViewControllerAnimated, which pops the current view controller (meal scene)
      // off the navigation stack of navigationController and performs an animation of the transition
      navigationController!.popViewController(animated: true)
    }
  }
  
  
  // This method lets you configure a view controller before it's presented
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if saveButton === sender as? UIBarButtonItem {
      // nil coalescing operator (??) is used to return the value of an optional if the optional has a value, or return a default value otherwise
      let name = nameTextField.text ?? ""
      let photo = photoImageView.image
      let rating = ratingControl.rating
      
      // Set the meal to be passed to MealTableViewController after the unwind segue
      meal = Meal(name: name, photo: photo, rating: rating)
    }
  }
  
  // MARK: Actions
  @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
    // Hide keyboard. Ensures that if user taps the image view while typing in the text field, the keyboard is dismissed properly
    nameTextField.resignFirstResponder()
    
    // UIImagePickerController is a view controller that lets a user pick media from their photo library
    let imagePickerController = UIImagePickerController()
    
    // Only allow photos to be picked, not taken.
    imagePickerController.sourceType = .photoLibrary
    
    // Make sure ViewController is notified when the user picks an image.
    imagePickerController.delegate = self
    
    present(imagePickerController, animated: true, completion: nil)
  }
  
}

