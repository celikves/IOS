//
//  ViewController.swift
//  Cat Breeds App
//
//  Created by vesile çelik on 11.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchFiels: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var favArray : [String] = UserDefaults.standard.stringArray(forKey: "FAVORITES") ?? []

    
    let serverAccess: ServerAccess = ServerAccess()
    var breeds = [BreedElement]()
    
    var searchStatus : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(favArray)
        
        tableView.delegate = self
        tableView.dataSource = self
        //searchFiels.delegate = self
        searchFiels.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let cell = UINib(nibName: "BreedTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "BreedTableViewCell")
        
        
        let favCell = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(favCell, forCellReuseIdentifier: "SearchTableViewCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favArray = UserDefaults.standard.stringArray(forKey: "FAVORITES") ?? []
        getData()
    }
    
    func getData(){
        self.view.startLoader()
        self.searchStatus = false
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
            self.breeds = response!
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.stopLoader()

            }
        })
    }
    
    fileprivate func searchFunction(_ text: String) {
        self.breeds.removeAll()

        if text.count >= 1{
            self.view.startLoader()
            self.searchStatus = true
            _ = serverAccess.getSearch(searchText: text, completionHandler: { response in
                if (response == nil){
                    let alert = UIAlertController(title: "Not Found", message: "Not found a cat with this name", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel)
                    alert.addAction(action)
//                    alert.addAction(action1)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                        self.view.stopLoader()

                    }
                    return
                }
                self.breeds = response ?? []
                DispatchQueue.main.async {
                    self.view.stopLoader()

                    self.tableView.reloadData()
                }
            })
        }else{
            getData()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        guard let text = textField.text else{
            return
        }
        searchFunction(text)
    }
    @IBAction func didTapButton(){
        let viewcontrol = UIViewController()
        viewcontrol.view.backgroundColor = .orange
        
        navigationController?.pushViewController(viewcontrol, animated: true)
    }
    @IBAction func didPressSearchButton(_ sender: UIButton) {
        searchFunction(searchFiels.text ?? "")
    }
    
}

extension ViewController : UITextFieldDelegate{

}

extension ViewController :  UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var faveStatus = false

        if searchStatus{
            if favArray.firstIndex(of: breeds[indexPath.row].id!) != nil{
                faveStatus = true
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else { return UITableViewCell() }
            cell.setData(name: breeds[indexPath.row].name ?? "", starStatus: faveStatus)
            return cell
        }else{
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchStatus{
            return 50
        }
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
