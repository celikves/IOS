//
//  DetailViewController.swift
//  Cat Breeds App
//
//  Created by vesile çelik on 19.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var breedDetail: UILabel!
    @IBOutlet weak var breedOrigin: UILabel!
    @IBOutlet weak var breedDogFriendly: UILabel!
    @IBOutlet weak var breedLifeSpan: UILabel!
    @IBOutlet weak var breedWikipediaURL: UILabel!
    @IBOutlet weak var breedDetailImage: UIImageView!
    
    var detail : String = ""
    var origin : String = ""
    var wikipediaURL : String = ""
    var dogFriendly : String = ""
    var lifeSpan : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        breedOrigin.text="Origin : \(origin)"
        breedLifeSpan.text="Life Span : \(lifeSpan)"
        breedDetail.text="\(detail)"
        //breedWikipediaURL.text="Wikipedia URL : \(wikipediaURL)"
        
    }
 

}
