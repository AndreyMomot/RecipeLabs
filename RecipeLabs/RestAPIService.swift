//
//  RestAPIService.swift
//  RecipeLabs
//
//  Created by Andrei Momot on 3/2/17.
//  Copyright © 2017 Dr_Mom. All rights reserved.
//

import Foundation
import Alamofire

class RestAPIService
{
  enum EndPoint: String {
    case baseUrl = "http://www.recipepuppy.com/api/?"
    case defaultURL = "i=onions,garlic&q=omelet&p=3"
    case searchURL = "q="
  }
    
  func defaultRecipe(completionHandler: @escaping (APIResult<Any>) -> Void)
  {
    let url = EndPoint.baseUrl.rawValue + EndPoint.defaultURL.rawValue
    
    Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
      
      switch(response.result) {
      case .success(let value):
        completionHandler(APIResult.success(value))
      case .failure(let error):
        completionHandler(APIResult.failure(error))
      }
    }
  }
  
  func searchRecipeBy(name: String, completionHandler: @escaping (APIResult<Any>) -> Void)
  {
    let url = EndPoint.baseUrl.rawValue + EndPoint.searchURL.rawValue + name
  
    Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
      
      switch(response.result) {
      case .success(let value):
        completionHandler(APIResult.success(value))
      case .failure(let error):
        completionHandler(APIResult.failure(error))
      }
    }
  }
}
