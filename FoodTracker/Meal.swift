//
//  Meal.swift
//  FoodTracker
//
//  Created by ronatory on 09.11.16.
//  Copyright © 2016 ronatory. All rights reserved.
//

import UIKit

class Meal {
  // MARK: Properties
  
  var name: String
  var photo: UIImage?
  var rating: Int
  
  // MARK: Initialization
  // Note: Its a failable initializer, which means that it's possible for the initializer to return nil after initialization
  init?(name: String, photo: UIImage?, rating: Int) {
    // Initialize stored properties.
    self.name = name
    self.photo = photo
    self.rating = rating
    
    // Initialization should fail if there is no name or if the rating is negative
    if name.isEmpty || rating < 0 {
      return nil
    }
  }
}
