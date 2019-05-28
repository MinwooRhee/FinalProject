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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath)
        
        cell.textLabel?.text = foodArray[indexPath.section][indexPath.row].name
        cell.detailTextLabel?.text = foodArray[indexPath.section][indexPath.row].ingredients
        
        return cell
    }
    @IBAction func editButtonTapped(_ sender: Any) {
        print("button tapped")
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
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
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedFood = foods.remove(at: fromIndexPath.row)
        foods.insert(movedFood, at: to.row)
        tableView.reloadData()
        Food.saveFoods(foods: foods)
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
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
