//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by ronatory on 09.11.16.
//  Copyright © 2016 ronatory. All rights reserved.
//

import UIKit
import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
  // MARK: FoodTracker Tests
  
  // Tests to confirm that the Meal initializer returns when no name or a negative rating is provided
  func testMealInitialization() {
    // Success case
    let potentialItem = Meal(name: "Newest meal", photo: nil, rating: 5)
    XCTAssertNotNil(potentialItem)
    
    // Failure cases
    let noName = Meal(name: "", photo: nil, rating: 0)
    // XCTAssertNil asserts that an object is nil
    // In this case, the noName object is nil, which implies that it failed initialization
    XCTAssertNil(noName, "Empty name is invalid")
  
    let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
    XCTAssertNil(badRating, "Negative ratings are invalid, be positive")
  }
}
