//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by ronatory on 09.11.16.
//  Copyright © 2016 ronatory. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
  
  // MARK: Properties
  
  var meals = [Meal]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Load the sample data
    loadSampleMeals()
  }
  
  // helper method to load sample data into the app
  func loadSampleMeals() {
    let photo1 = UIImage(named: "meal1")!
    let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4)!
    
    let photo2 = UIImage(named: "meal2")!
    let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5)!
    
    let photo3 = UIImage(named: "meal3")!
    let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3)!
    
    // add the meal objects to the meals array
    meals += [meal1, meal2, meal3]
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // show 1 section
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // how many rows
    return meals.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier
    let cellIdentifier = "MealTableViewCell"
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell
    
    // Fetches the appropriate meal for the data source layout.
    let meal = meals[indexPath.row]
    
    cell.nameLabel.text = meal.name
    cell.photoImageView.image = meal.photo
    cell.ratingControl.rating = meal.rating
    
    return cell
  }
  
  @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
      // Add a new meal
      // Note: computes the location in the table view where the new table view cell representing the new meal
      // will be inserted and stores it in a local constant called newIndexPath
      let newIndexPath = IndexPath(row: meals.count, section: 0)
      meals.append(meal)
      tableView.insertRows(at: [newIndexPath], with: .bottom)
    }
  }
  
}
