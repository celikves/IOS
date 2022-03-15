//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ImageViewDiceOne: UIImageView!
    @IBOutlet weak var ImageViewDiceTwo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageViewDiceTwo.image = #imageLiteral(resourceName: "DiceTwo")
        ImageViewDiceOne.image = #imageLiteral(resourceName: "DiceSix")
        //ImageViewDiceOne.alpha = 0.5
    
    }


}

