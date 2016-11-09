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
    
    // Use the edit button item provided by the table view controller
    navigationItem.leftBarButtonItem = editButtonItem
    
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
  
  // Override to support editing the table view
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // Delete the row from the data source
      meals.remove(at: indexPath.row)
      
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array and add a new row to the table view
    }
  }
  
  // Override to support conditional editing og the table view
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable
    return true
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
      
      // checks weather a row in the table view is selected. If yes, that means a user tapped one of the table views
      // cells to edit a meal. In other words, this if statement gets executed if an existing meal is being edited
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
        // Update an existing meal
        meals[selectedIndexPath.row] = meal
        tableView.reloadRows(at: [selectedIndexPath], with: .none)
      } else {
        // Add a new meal, user tapped on the add button
        // Note: computes the location in the table view where the new table view cell representing the new meal
        // will be inserted and stores it in a local constant called newIndexPath
        let newIndexPath = IndexPath(row: meals.count, section: 0)
        meals.append(meal)
        tableView.insertRows(at: [newIndexPath], with: .bottom)
      }
    }
  }
  
  // MARK: Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowDetail" {
      let mealDetailViewController = segue.destination as! MealViewController
      
      // Get the cell that generated this segue
      // fetches the Meal object corresponding to the selected cell in the table view
      // it then assigns that Meal object to the meal property of the destination view controller an instance of
      // MealViewController
      if let selectedMealCell = sender as? MealTableViewCell {
        let indexPath = tableView.indexPath(for: selectedMealCell)!
        let selectedMeal = meals[indexPath.row]
        mealDetailViewController.meal = selectedMeal
      }
    } else if segue.identifier == "AddItem" {
      print("Adding new meal")
    }
  }
  
}
