//
//  SearchViewController.swift
//  Search App
//
//  Created by SE on 10/3/18.
//  Copyright © 2018 IT15049582_IT15060822. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let data:[App] = []
    
    var filteredData: [App] = []
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.delegate = self
        filteredData = [];
//        self.searchApps(searchKey: "PUBG");
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Tells the delegate that the search button was tapped."+searchBar.text!);
        if(searchBar.text != nil) {
            self.searchApps(searchKey: searchBar.text!)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row].trackName
        cell.detailTextLabel?.text = filteredData[indexPath.row].sellerName
        let data = try? Data(contentsOf: URL(string: filteredData[indexPath.row].artworkUrl512)!)
        cell.imageView?.image = UIImage(data: data!)
        cell.imageView?.layer.cornerRadius = 10
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("asaa")
        self.tableView.deselectRow(at: indexPath, animated: false)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        print(self.filteredData[indexPath.row].trackName)
        self.ShowPopUp(selectApp: self.filteredData[indexPath.row])
   
    }
    
    func ShowPopUp(selectApp :App) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalPopUpId") as! AppModalViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        popOverVC.setModal(AppDetails: selectApp)
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    func searchApps(searchKey: String){
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        searchBar.addSubview(activityIndicator)
        activityIndicator.frame = searchBar.bounds

            activityIndicator.startAnimating()
            AppService().searchStoreForTerm(searchKey, completion:
                {
                    results, error in
                    activityIndicator.removeFromSuperview()
                    
                    if let error = error {
                        print("Error searching : \(error)")
                        let alert = UIAlertController(title: "Network Error", message: "Check your network connection and try again.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    
                    if let results: NSDictionary = results as? NSDictionary {
                        
                        self.filteredData = []
                        if let resultset = results.value(forKey: "results") as? NSArray {
                            
                            for item in resultset{
                                //                                print(item.key["sellerName"])
                                if let dic = item as? NSDictionary {
                                    print(dic.value(forKey: "sellerName")!)
                                    if((dic.value(forKey: "trackCensoredName") ) != nil && (dic.value(forKey: "sellerName") ) != nil &&
                                        (dic.value(forKey: "artworkUrl512")) != nil && dic.value(forKey: "primaryGenreName") != nil ) {
                                        
                                        self.filteredData.append(App(trackName: dic.value(forKey: "trackCensoredName")! as! String, sellerName: dic.value(forKey: "sellerName")! as! String, artworkUrl512: dic.value(forKey: "artworkUrl512")! as! String, wrapperType: dic.value(forKey: "wrapperType") as? String ?? "" , primaryGenreName: dic.value(forKey: "primaryGenreName")! as! String, formattedPrice: dic.value(forKey: "formattedPrice") as? String ?? "" ))
                                        
                                    }
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
            })
        
    }
    
    
    
}



