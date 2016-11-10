//
//  Meal.swift
//  FoodTracker
//
//  Created by ronatory on 09.11.16.
//  Copyright © 2016 ronatory. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
  // MARK: Properties
  
  var name: String
  var photo: UIImage?
  var rating: Int
  
  // MARK: Archiving Paths
  
  static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
  
  // MARK: Types
  
  struct PropertyKey {
    static let nameKey = "name"
    static let photoKey = "photo"
    static let ratingKey = "rating"
  }
  
  // MARK: Initialization
  // Note: Its a failable initializer, which means that it's possible for the initializer to return nil after initialization
  init?(name: String, photo: UIImage?, rating: Int) {
    // Initialize stored properties.
    self.name = name
    self.photo = photo
    self.rating = rating
    
    super.init()
    
    // Initialization should fail if there is no name or if the rating is negative
    if name.isEmpty || rating < 0 {
      return nil
    }
  }
  
  // MARK: NSCoding
  
  func encode(with aCoder: NSCoder) {
    // encodes the value of each property on the Meal class and store them with their corresponding key
    aCoder.encode(name, forKey: PropertyKey.nameKey)
    aCoder.encode(photo, forKey: PropertyKey.photoKey)
    aCoder.encode(rating, forKey: PropertyKey.ratingKey)
  }
  
  // required: means the initializer must be implemented on every subclass of the class that defines this initializer
  // convenience: these initializer are secondary, supporting initializers that need to call one of their class. here you're declaring
  // this initializer as a convenience initializer because it only applies when there's saved data to be loaded
  required convenience init?(coder aDecoder: NSCoder) {
    // decodeObject(_:) method unarchives the stored information stored about an object
    let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
    // because photo is an optional property of Meal, use conditional cast
    let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
    
    let rating = aDecoder.decodeInteger(forKey: PropertyKey.ratingKey)
    
    // must call designated initializer
    // Note: as convenience initializer, this initializer is required to call one of its class's designated initializers before completing
    // as the initializer's arguments, you pass in the values of the constants you created while archiving the saved data.
    self.init(name: name, photo: photo, rating: rating)
  }
}
