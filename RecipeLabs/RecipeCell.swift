//
//  RecipeCell.swift
//  RecipeLabs
//
//  Created by Andrei Momot on 3/2/17.
//  Copyright © 2017 Dr_Mom. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell
{  
  @IBOutlet weak var photoView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var ingredientsLabel: UILabel!
  
  var recipe: Recipe! {
    didSet {
      titleLabel.text = recipe.title
      ingredientsLabel.text = recipe.ingredients
      if let imageURL = recipe.image {
        guard let imageData: NSData = NSData(contentsOf: imageURL) else {
          print("Image URL is missing")
          return
        }
        self.photoView.image = UIImage(data: imageData as Data)
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCell()
  }
  
  func configureCell()
  {
    self.backgroundColor = UIColor.clear
    self.selectionStyle = .default
    
    self.titleLabel.textColor = UIColor.black
    self.titleLabel.font = UIFont(name: "Avenir-bolt", size: 18)
    self.titleLabel.textAlignment = .left
    self.titleLabel.numberOfLines = 1
    
    self.ingredientsLabel.textColor = UIColor.black
    self.ingredientsLabel.font = UIFont(name: "Avenir-light", size: 12)
    self.ingredientsLabel.textAlignment = .left
    self.ingredientsLabel.numberOfLines = 0
    
    self.photoView.layer.borderWidth = 1.0
    self.photoView.layer.masksToBounds = false
    self.photoView.layer.borderColor = UIColor.gray.cgColor
    self.photoView.layer.cornerRadius = photoView.frame.size.height / 2
    self.photoView.clipsToBounds = true
  }
}
