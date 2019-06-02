//
//  RecipeTableView.swift
//  Foodoodoodoo
//
//  Created by Min Woo on 5/13/19.
//  Copyright © 2019 Min Woo. All rights reserved.
//

import UIKit

class RecipeTableView: UITableViewController {
    
    var foods = [Food]()
    var foodArray = [[Food](), [Food](), [Food]()]
    // Array of arrays of food, sorted by type

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        // one section for each type of food
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Appetizer"
        case 1:
            return "Entree"
        case 2:
            return "Dessert"
        default:
            return ""
        }
        // give names to the sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray[section].count
        // set numbers of rows in sections for foods in each array
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath)
        
        cell.textLabel?.text = foodArray[indexPath.section][indexPath.row].name
        cell.detailTextLabel?.text = foodArray[indexPath.section][indexPath.row].ingredients
        
        return cell
        // display name and ingredients of foods on each cell
    }
    @IBAction func editButtonTapped(_ sender: Any) {
        print("button tapped")
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
        // goes into editing mode when edit button is tapped
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foods.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        Food.saveFoods(foods: foods)
        // delete a cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedFood = foods.remove(at: fromIndexPath.row)
        foods.insert(movedFood, at: to.row)
        tableView.reloadData()
        Food.saveFoods(foods: foods)
        // move a food to different section
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let myFoods = Food.loadFoods() {
            foods = myFoods
        }
        else {
            foods = Food.loadSampleRecipe()
        }
        // load recipes. if there aren't any, load sample recipes
        
        for  food in foods {
            switch food.type {
            case "appetizer":
                foodArray[0].append(food)
            case "entree":
                foodArray[1].append(food)
            case "dessert":
                foodArray[2].append(food)
            default:
                foodArray[0].append(food)
            }
            // append foods to arrays corresponding to types
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! AddEditViewController
        
        if let food = sourceViewController.food {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                foods[selectedIndexPath.row] = food
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: foods.count, section: 0)
                foods.append(food)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        Food.saveFoods(foods: foods)
        // unwind function
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditFood" {
            let indexPath = tableView.indexPathForSelectedRow!
            let food1 = foods[indexPath.row]
            //let navController = segue.destination as! UINavigationController
            let destinationVC = segue.destination as! AddEditViewController
            destinationVC.food = food1
        }
    }
*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
