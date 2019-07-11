//
//  SearchVC.swift
//  Box
//
//  Created by Jun Seub Lim on 02/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let recommendList = ["물티슈", "가그린", "화장실 슬리퍼", "음식물 쓰레기통", "규조토 발 매트"]
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var SearchTV: UITableView!
 
    @IBOutlet var recentView: UIView!
    @IBOutlet var recommendBtn: UIButton!
    @IBOutlet var recommendView: UIView!
    @IBOutlet var recentBtn: UIButton!
    let recentSearchDAO = RecentSearchedDAO()
    var btnSelected = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SearchTV.separatorStyle = .none
        self.SearchTV.delegate = self
        self.SearchTV.dataSource = self
        self.searchBar.delegate = self
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
        let removedString = appDelegate.recentSearched[(indexPath?.row)!]
        let rs = recentSearchDAO.remove(searched: removedString)
        if rs == true {
        
        appDelegate.recentSearched.remove(at: (indexPath! as NSIndexPath).row)
        SearchTV.deleteRows(at: [indexPath!], with: .fade)
        return
        }
        
    }
    @IBAction func recentTouched(_ sender: Any) {
        recentView.backgroundColor = UIColor.pumpkinOrange
        recommendView.backgroundColor = UIColor.lightBlueGrey
        recentBtn.setTitleColor(UIColor.pumpkinOrange, for: .normal)
        recommendBtn.setTitleColor(UIColor.darkGrey, for: .normal)
        btnSelected = 0
        SearchTV.reloadData()
        
    }
    @IBAction func recommendTouched(_ sender: Any) {
        recentView.backgroundColor = UIColor.lightBlueGrey
        recommendView.backgroundColor = UIColor.pumpkinOrange
        recentBtn.setTitleColor(UIColor.darkGrey, for: .normal)
        recommendBtn.setTitleColor(UIColor.pumpkinOrange, for: .normal)
         btnSelected = 1
        SearchTV.reloadData()
       
    }
    
}
    extension SearchVC: UITableViewDelegate {
        
    }
extension SearchVC: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if btnSelected == 0 {
    return appDelegate.recentSearched.count
    }
    return recommendList.count
    
}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flag = btnSelected
        
        switch flag {
        case 0 :
            let cell = SearchTV.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath)
            cell.textLabel!.text = appDelegate.recentSearched[indexPath.row]
            cell.textLabel!.font = UIFont(name: "NotoSans-Medium.ttf", size: 17)
            
            return cell
        case 1:
            let cell = SearchTV.dequeueReusableCell(withIdentifier: "recommendCell", for: indexPath)
                        cell.textLabel!.text = recommendList[indexPath.row]
            cell.textLabel!.font = UIFont(name: "NotoSans-Medium.ttf", size: 17)
            
            return cell
        default:
            break
        }
        let cell = SearchTV.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath)
                cell.textLabel!.text = appDelegate.recentSearched[indexPath.row]
        cell.textLabel!.font = UIFont(name: "NotoSans-Medium.ttf", size: 17)

    return cell
}

}
extension SearchVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searched = searchBar.text
        if searched == "" {
            return
        }
        let rs = recentSearchDAO.create(searched: searched!)
        if rs == true {
        appDelegate.recentSearched.insert(searched!, at: 0)
        SearchTV.reloadData()
        }
    }
    
}
