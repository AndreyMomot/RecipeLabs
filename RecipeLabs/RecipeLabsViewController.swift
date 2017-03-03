//
//  RecipeLabsViewController.swift
//  RecipeLabs
//
//  Created by Andrei Momot on 3/2/17.
//  Copyright © 2017 Dr_Mom. All rights reserved.
//

import UIKit
import CoreData

class RecipeLabsViewController: UIViewController
{
  enum TableViewIdentifier: String
  {
    case recipeCell = "RecipeCell"
  }

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchTextField: UITextField!
  
  var recipe = [Recipe]() {
    didSet {
      tableView.reloadData()
    }
  }
  //var recipeEntity: [NSManagedObject] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableViewInitialSetUp()
  }
    
  private func tableViewInitialSetUp()
  {
    let nib = UINib(nibName: TableViewIdentifier.recipeCell.rawValue, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: TableViewIdentifier.recipeCell.rawValue)
    // Removes empty cells after footer.
    tableView.tableFooterView = UIView()
  }
  
  func loadDefaultRecipes()
  {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      fatalError()
    }
    let apiService = appDelegate.applicationManager.apiService
    
    apiService.defaultRecipe { (result) in
      switch(result) {
      case .success(let value):
        print(value)
        let response = value as? [String: Any]
        if let results = response?["results"] as? [[String: Any]] {
        for result in results {
          let recipeItem = Recipe(dictionary: result)
          self.recipe.append(recipeItem)
          }
        }
            case .failure(let error):
            print("****** error from get recipes: \(error)")
      }
    }
  }
  
  
//  func textFieldBackspace(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//    let  char = string.cString(using: String.Encoding.utf8)!
//    let isBackSpace = strcmp(char, "\\b")
//    
//    if (isBackSpace == -92) {
//      recipe.removeAll()
//      tableView.reloadData()
//      loadRecipes()
//      print("Backspace was pressed")
//    }
//    return true
//  }
  
  @IBAction func textFieldPrimaryActionTriggered(_ sender: Any)
  {
      recipe.removeAll()
      tableView.reloadData()
      loadSearchedRecipes()
  }
  
  func loadSearchedRecipes()
  {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      fatalError()
    }
    let apiService = appDelegate.applicationManager.apiService
    
    let recipe = searchTextField.text
    
    apiService.searchRecipeBy(name: recipe!) { (result) in
      switch(result) {
      case .success(let value):
        print(value)
        let response = value as? [String: Any]
        if let results = response?["results"] as? [[String: Any]] {
          for result in results {
            let recipeItem = Recipe(dictionary: result)
            self.recipe.insert(recipeItem, at: 0)
          }
        }
      case .failure(let error):
        print("****** error from get recipes: \(error)")
      }
    }
  }
  
  
  func goToLink(url: URL)
  {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}

// MARK: - UITableViewDataSource
extension RecipeLabsViewController: UITableViewDataSource
{
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewIdentifier.recipeCell.rawValue) as? RecipeCell else {
      fatalError()
    }
    let recipeItem = recipe[indexPath.row]
    cell.recipe = recipeItem
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return recipe.count
  }
}

// MARK: - UITableViewDelegate
extension RecipeLabsViewController: UITableViewDelegate
{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedRecipe = recipe[indexPath.row]
    if let url = selectedRecipe.reference {
      self.goToLink(url: url)
    }
  }
}


