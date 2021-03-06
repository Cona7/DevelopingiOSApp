//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Josip Glasovac on 12/10/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import UIKit
import os.log
import Storable

class MealTableViewController: UITableViewController {

    var mealsArray = MealsArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem

        loadSampleMeals()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch segue.identifier ?? "" {

        case "AddItem":
                os_log("Adding a new meal.", log: OSLog.default, type: .debug)

        case "ShowDetail":
                guard let mealDetailViewController = segue.destination as? MealViewController else {
                        fatalError("Unexpected destination: \(segue.destination)")
                }

                guard let selectedMealCell = sender as? MealTableViewCell else {
                        fatalError("Unexpected sender: \(String(describing: sender))")
                }

                guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }

                let selectedMeal = mealsArray.meals[indexPath.row]

                mealDetailViewController.meal = selectedMeal

        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController,
            let meal = sourceViewController.meal {

            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                mealsArray.meals[selectedIndexPath.row] = meal

                tableView.reloadData()
            } else {
                let newIndexPath = IndexPath(row: mealsArray.meals.count, section: 0)

                mealsArray.meals.append(meal)

                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveMeals()
        }
    }
}

extension MealTableViewController {

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsArray.meals.count
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            mealsArray.meals.remove(at: indexPath.row)

            saveMeals()

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        let meal = mealsArray.meals[indexPath.row]

        cell.nameLabel.text = meal.name
        cell.photo.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }
}

extension MealTableViewController {

    private func loadSampleMeals() {
        do {
            mealsArray = try MealsArray.fetchFromUserDefaults()
        } catch {
            print("can't load Meals")
        }
        if mealsArray.meals.isEmpty {
            loadDefaultValues()
        }
    }

    func saveMeals() {
        do {
            try mealsArray.saveInUserDefaults()
        } catch {
            print("can't save Meals")
        }
    }

    func loadDefaultValues() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")

        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }

        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }

        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal2")
        }

        mealsArray.meals = [meal1, meal2, meal3]
    }
}
