//
//  APIService.swift
//  RecipeLabs
//
//  Created by Andrei Momot on 3/2/17.
//  Copyright © 2017 Dr_Mom. All rights reserved.
//

import UIKit

enum APIResult<T>
{
  case success(T)
  case failure(Error)
}

class APIService
{
  let restAPIService = RestAPIService()
  
  func defaultRecipe(completionHandler: @escaping (APIResult<Any>) -> Void)
  {
    restAPIService.defaultRecipe(completionHandler: completionHandler)
  }
  
  func searchRecipeBy(name: String, completionHandler: @escaping (APIResult<Any>) -> Void)
  {
    restAPIService.searchRecipeBy(name: name, completionHandler: completionHandler)
  }
}
