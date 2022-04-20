//
//  BreedTableViewCell.swift
//  Cat Breeds App
//
//  Created by vesile çelik on 18.04.2022.
//

import UIKit

class BreedTableViewCell: UITableViewCell {

    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var breedsName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        breedImage.layer.cornerRadius = breedImage.frame.size.height / 2
        breedImage.clipsToBounds = true
        
    }
    
    func setData(name : String , imageUrl : String ,origin : String ,life_span : String,description:String,detailsImageUrl:String, starStatus : Bool){
        breedsName.text = name
        if starStatus{
            starButton.setImage(UIImage(named: "star.fill"), for: .normal)
        }else{
            starButton.setImage(UIImage(named: "star"), for: .normal)
        }
    }

    @IBAction func didPressAddToFavoites(_ sender: UIButton) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
