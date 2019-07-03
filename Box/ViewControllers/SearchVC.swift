//
//  SearchVC.swift
//  Box
//
//  Created by Jun Seub Lim on 02/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    let recentList = ["물티슈","가그린","c","d","e"]
    let recommendList = ["x","y","z"]
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var SearchTV: UITableView!
 
    @IBOutlet var recentView: UIView!
    @IBOutlet var recommendBtn: UIButton!
    @IBOutlet var recommendView: UIView!
    @IBOutlet var recentBtn: UIButton!
    var returnList = [String]()
    var btnSelected = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SearchTV.separatorStyle = .none
        self.SearchTV.delegate = self
        self.SearchTV.dataSource = self
        self.searchBar.delegate = self
        returnList = recentList
        recentView.backgroundColor = UIColor.pumpkinOrange
        recommendView.backgroundColor = UIColor.lightBlueGrey
recentBtn.setTitleColor(UIColor.pumpkinOrange, for: .normal)
recommendBtn.setTitleColor(UIColor.darkGrey, for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGrey], for: .normal)
    }
    @IBAction func deleteCell(_ sender: Any) {
        guard let cell = (sender as AnyObject).superview?.superview as? UITableViewCell else {
            return
        }
        
        let indexPath = SearchTV.indexPath(for: cell)
        
        returnList.remove(at: (indexPath! as NSIndexPath).row)
        SearchTV.deleteRows(at: [indexPath!], with: .fade)
    }
    @IBAction func recentTouched(_ sender: Any) {
        recentView.backgroundColor = UIColor.pumpkinOrange
        recommendView.backgroundColor = UIColor.lightBlueGrey
        recentBtn.setTitleColor(UIColor.pumpkinOrange, for: .normal)
        recommendBtn.setTitleColor(UIColor.darkGrey, for: .normal)
        returnList = recentList
        SearchTV.reloadData()
        btnSelected = 0
    }
    @IBAction func recommendTouched(_ sender: Any) {
        recentView.backgroundColor = UIColor.lightBlueGrey
        recommendView.backgroundColor = UIColor.pumpkinOrange
        recentBtn.setTitleColor(UIColor.lightBlueGrey, for: .normal)
        recommendBtn.setTitleColor(UIColor.pumpkinOrange, for: .normal)
        returnList = recommendList
        SearchTV.reloadData()
        btnSelected = 1
    }
    
}
    extension SearchVC: UITableViewDelegate {
        
    }
extension SearchVC: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return returnList.count
    
}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flag = btnSelected
        
        switch flag {
        case 0 :
            let cell = SearchTV.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath)
            cell.textLabel!.text = returnList[indexPath.row]
            cell.textLabel!.font = UIFont(name: "SF-Pro-Text-Medium", size: 17)
            
            return cell
        case 1:
            let cell = SearchTV.dequeueReusableCell(withIdentifier: "recommendCell", for: indexPath)
                        cell.textLabel!.text = returnList[indexPath.row]
            cell.textLabel!.font = UIFont(name: "SF-Pro-Text-Medium", size: 17)
            
            return cell
        default:
            break
        }
        let cell = SearchTV.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath)
                cell.textLabel!.text = recentList[indexPath.row]
        cell.textLabel!.font = UIFont(name: "SF-Pro-Text-Medium.otf", size: 17)

    return cell
}

}
extension SearchVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
