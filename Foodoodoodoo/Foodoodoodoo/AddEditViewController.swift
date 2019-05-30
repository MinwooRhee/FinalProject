//
//  AddEditViewController.swift
//  Foodoodoodoo
//
//  Created by Min Woo on 5/23/19.
//  Copyright © 2019 Min Woo. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var stepsTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var food: Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let food = food {
            nameTextView.text = String(food.name)
            ingredientsTextView.text = food.ingredients
            stepsTextView.text = food.steps
        }

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let name = nameTextView.text ?? ""
        let ingredients = ingredientsTextView.text ?? ""
        let steps = stepsTextView.text ?? ""
        food = Food(name: name, ingredients: ingredients, steps: steps, type: "appetizer")
    }
    
    func updateSaveButtonState() {
        let nameText = nameTextView.text ?? ""
        let ingredientsText = ingredientsTextView.text ?? ""
        let stepsText = stepsTextView.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty && !ingredientsText.isEmpty && !stepsText.isEmpty
    }
    
    @IBAction func textEditingChanged(_ sender: UITextView) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextView) {
        sender.resignFirstResponder()
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
