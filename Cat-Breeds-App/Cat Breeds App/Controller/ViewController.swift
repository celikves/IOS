//
//  ViewController.swift
//  Cat Breeds App
//
//  Created by vesile çelik on 11.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    let serverAccess: ServerAccess = ServerAccess()
    var breeds = [BreedElement]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let cell = UINib(nibName: "BreedTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "BreedTableViewCell")
        
        _ = serverAccess.get(completionHandler: { response in
            print(response ?? "nil")
            print(response?[0].image?.url ?? "")
            self.breeds = response!
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        })
        
        
        
    }
    
    @IBAction func didTapButton(){
        let viewcontrol = UIViewController()
        viewcontrol.view.backgroundColor = .orange
        
        navigationController?.pushViewController(viewcontrol, animated: true)
    }
}

extension ViewController :  UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedTableViewCell") as? BreedTableViewCell
        cell?.setData(name: breeds[indexPath.row].name,life_span: breeds[indexPath.row].life_span
                      , imageUrl: breeds[indexPath.row].image?.url ?? "", starStatus: false)
        let image = downloadImage(with: breeds[indexPath.row].image?.url ?? "") { image in
            cell?.breedImage.image = image
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        vc!.name = breeds[indexPath.row].name
        
        vc!.lifeSpan = breeds[indexPath.row].life_span
        
        /*let image = downloadImage(with: breeds[indexPath.row].image?.url ?? "") { image in
            vc?.breedDetailImage.image = image
        }
         */
        //vc?.breedDetailImage = image
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
