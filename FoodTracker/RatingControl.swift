//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Ronny Glotzbach on 09.11.16.
//  Copyright © 2016 Ronny Glotzbach. All rights reserved.
//

import UIKit

class RatingControl: UIView {
  
  // MARK: Properties
  
  var rating = 0 {
    // a property observer observes and responds to changes in a propertys value
    // property observers are called every time a propertys value is set and can be used to perform work immediately
    // before or after the value changes. didSet property observer is called immediately after the propertys value is set
    // you include a call to setNeedsLayout(), which will trigger a layout update every time the rating changes. this ensures
    // that the UI is always showing an accurate representation of the rating property value
    didSet {
      setNeedsLayout()
    }
  }
  var ratingButtons = [UIButton]()
  let spacing = 5
  let starCount = 5
  

  // MARK: Initialization
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    let filledStarImage = UIImage(named: "filledStar")
    let emptyStarImage = UIImage(named: "emptyStar")
    
    // iterate from 0 to 4 with wildcard (don't need to know which iteration of the loop is currently executing)
    for _ in 0..<starCount {
      // Add a button
      let button = UIButton()
      
      button.setImage(emptyStarImage, for: .normal)
      button.setImage(filledStarImage, for: .selected)
      // occurs when user is in process of tapping the button
      button.setImage(filledStarImage, for: [.highlighted, .selected])
      
      // make sure that the image doesn't show an additional highlight during the state change
      button.adjustsImageWhenHighlighted = false
      
      // target-action pattern
      // you've also used this pattern to link elements in your storyboard to action methods in your code
      // here you're dooing the same except you're creating the connection in code. You're attaching the ratingButtonTapped(button:) action method
      // to the button object, which will be triggered whenever the .TouchDown event occurs
      // this event signifies that the user has pressed on a button
      // set the target to self, shich is the RatingControl in this case
      // the #selector expresson returns the Selector value for the provided method
      // A selector is an opaque value that identifies the method
      // here the #selector(RatingControl.ratingButtonTapped(button:)) expression returns the selector for your ratingButtonTapped(button:)
      // this lets the system call your action method when the button is tapped
      button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchDown)
      
      // add button to array
      ratingButtons += [button]
      addSubview(button)
    }
  }
  
  override func layoutSubviews() {
    // Set the buttons width and height to a square the size of the frame's height
    let buttonSize = Int(frame.size.height)
    
    // create a button frame
    var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
    
    // Offset each button's origin by the length of the button plus spacing
    for (index, button) in ratingButtons.enumerated() {
      // frame locations are set equal to a standard button size of 44 and 5 points of padding, multiplied by index
      buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
      button.frame = buttonFrame
    }
    
    updateButtonSelectionStates()
  }

  override var intrinsicContentSize: CGSize {
    let buttonSize = Int(frame.size.height)
    // calculate the controls size accounting for each of the stars and the spaces between them (one less space than stars, assuming you have at least one star)
    let width = (buttonSize * starCount) + (spacing * (starCount - 1))
    
    return CGSize(width: width, height: buttonSize)
  }
  
  // MARK: Button Action
  func ratingButtonTapped(button: UIButton) {
    rating = ratingButtons.index(of: button)! + 1
    
    updateButtonSelectionStates()
  }
  
  // helper method to update the selction state of the buttons
  func updateButtonSelectionStates() {
    for (index, button) in ratingButtons.enumerated() {
      // if index of a button is less than the rating, that button should be selected.
      button.isSelected = index < rating
    }
  }
  
}
