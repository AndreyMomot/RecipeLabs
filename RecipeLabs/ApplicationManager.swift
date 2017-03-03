//
//  ApplicationManager.swift
//  RecipeLabs
//
//  Created by Andrei Momot on 3/2/17.
//  Copyright © 2017 Dr_Mom. All rights reserved.
//

import Foundation

class ApplicationManager
{
  lazy var apiService: APIService = {
    
    let service = APIService()
    
    return service
    
  }()
}
