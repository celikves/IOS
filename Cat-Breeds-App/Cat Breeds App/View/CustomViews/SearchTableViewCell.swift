//
//  SearchTableViewCell.swift
//  Cat Breeds App
//
//  Created by vesile çelik on 5.05.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var breedsName: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(name : String, starStatus : Bool){
        breedsName.text = name
        if starStatus{
            starButton.setImage(UIImage(named: "star1"), for: .normal)
        }else{
            starButton.setImage(UIImage(named: "star"), for: .normal)
        }
    }

}
