//
//  FavoritesViewController.swift
//  Cat Breeds App
//
//  Created by vesile çelik on 5.05.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var favArray : [String] = UserDefaults.standard.stringArray(forKey: "FAVORITES") ?? []
    let serverAccess: ServerAccess = ServerAccess()
    var breeds = [BreedElement]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let cell = UINib(nibName: "BreedTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "BreedTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favArray = UserDefaults.standard.stringArray(forKey: "FAVORITES") ?? []
        getData()
    }
    
    func getData(){
        self.view.startLoader()
        self.breeds.removeAll()
        _ = serverAccess.get(completionHandler: { response in
            print(response ?? "nil")
            guard response != nil else{
                self.presentAlertWithTitle(title: "Ops", message: "Failed to fetch data!!", options: "Reload" , "Cancel") { options in
                    switch options{
                    case "Reload":
                        self.getData()
                        break
                    case "Cancel":
                        print("cancel pressed")
                        break
                    default:
                        break
                    }
                }
                self.view.stopLoader()
                return
            }
//            print(response?[0].image?.url ?? "")
            
            for item in response!{
                if let index = self.favArray.firstIndex(of: item.id!){
                    self.breeds.append(item)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.tableView.reloadData()
                self.view.stopLoader()

            }
        })
    }
}

extension FavoritesViewController :  UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var faveStatus = false
        if favArray.firstIndex(of: breeds[indexPath.row].id!) != nil{
            faveStatus = true
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BreedTableViewCell") as? BreedTableViewCell else { return UITableViewCell() }
        cell.setData(name: breeds[indexPath.row].name ?? "",
                      imageUrl: breeds[indexPath.row].image?.url ?? "",
                      origin: breeds[indexPath.row].origin ?? "",
                      life_span:breeds[indexPath.row].life_span ?? "",
                      description:breeds[indexPath.row].description ?? "",
                      detailsImageUrl:breeds[indexPath.row].image?.url ?? "" ,
                      starStatus: faveStatus)
        cell.actionHandler = {
            if let index = self.favArray.firstIndex(of: self.breeds[indexPath.row].id!) {
                self.favArray.remove(at: index)
                UserDefaults.standard.set(self.favArray, forKey: "FAVORITES")

            } else {
                // not found
                self.favArray.append(self.breeds[indexPath.row].id!)
                UserDefaults.standard.set(self.favArray, forKey: "FAVORITES")

            }
            tableView.reloadData()
        }

        let image = downloadImage(with: breeds[indexPath.row].image?.url ?? "") { image in
            cell.breedImage.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        //vc!.name = breeds[indexPath.row].name
        //let image = downloadImage(with: breeds[indexPath.row].detailsPageImage?.url ?? "") { image in
         //   vc!.breedDetailImage.image = image
       // }
        vc?.breedImageUrl = breeds[indexPath.row].image?.url ?? ""
        vc!.origin = breeds[indexPath.row].origin ?? ""
        vc!.lifeSpan = breeds[indexPath.row].life_span ?? ""
        vc?.detail = breeds[indexPath.row].description ?? ""
        vc!.wikipediaURL = breeds[indexPath.row].wikipedia_url ?? ""

        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
