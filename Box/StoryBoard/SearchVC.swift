//
//  SearchVC.swift
//  Box
//
//  Created by Jun Seub Lim on 02/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    let recentList = ["a","b","c","d","e"]
    let recommendList = ["x","y","z"]
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var SearchTV: UITableView!
    var returnList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SearchTV.delegate = self
        self.SearchTV.dataSource = self
        registerTVC()
        returnList = recentList
    }
    func registerTVC() {
            let nibName = UINib(nibName: "SearchTVC", bundle: nil)
            SearchTV.register(nibName, forCellReuseIdentifier: "SearchTVC")
    }
}
    extension SearchVC: UITableViewDelegate {
        
    }
extension SearchVC: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return returnList.count
    
}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = SearchTV.dequeueReusableCell(withIdentifier: "SearchTVC") as! SearchTVC
    cell.recentSearchDelete(<#T##sender: Any##Any#>)
    let searchitem = recentList[indexPath.row]
    
    cell.searchItemName.text = searchitem

    return cell
}

}
