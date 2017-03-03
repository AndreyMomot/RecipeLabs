//
//  Recipes.swift
//  RecipeLabs
//
//  Created by Andrei Momot on 3/2/17.
//  Copyright © 2017 Dr_Mom. All rights reserved.
//

import Foundation

struct Recipe {
  
  var title: String?
  var ingredients: String?
  var image: URL?
  var reference: URL?
    
  init(dictionary: [String: Any]) {
    self.title = dictionary["title"] as? String? ?? ""
    self.ingredients = dictionary["ingredients"] as? String? ?? ""
    self.image = URL(string: dictionary["thumbnail"] as? String ?? "")
    self.reference = URL(string: dictionary["href"] as? String ?? "")
  }
}
