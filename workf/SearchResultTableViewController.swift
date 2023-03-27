//
//  SearchResultTableViewController.swift
//  workf
//
//  Created by NICOLAS ENRICO. on 2021/6/9.
//


import UIKit

class SearchResultTableViewController: UITableViewController , UISearchResultsUpdating{

    

    var allNews:[[String:AnyObject]]?
    var filterNews:[[String:AnyObject]] = []
    var nav :UINavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()

        let xibs = UINib(nibName:"NewsTableViewCell",bundle: nil)
        tableView.register(xibs, forCellReuseIdentifier: "FavorSearchCell")
        tableView.rowHeight = 210
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier:"FavorSearchCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard  let searchString = searchController.searchBar.text else{return}
        if searchString.isEmpty{return}
        
        filterNews = Favor.SearchFavor(title: searchString)
        

        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterNews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavorSearchCell", for: indexPath) as! NewsTableViewCell
        cell.TittleLabel.text = filterNews[indexPath.row]["title"] as? String
        cell.TimeLabel.text = filterNews[indexPath.row]["passtime"] as?String
        let iurl = URL(string: filterNews[indexPath.row]["image"]as! String)
        let data = try! Data(contentsOf: iurl!)
        cell.ImageShow.image = UIImage(data: data)
        // Configure the cell...

        return cell
    }
    


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainstoryboard = UIStoryboard(name:"Main",bundle: nil)
        let detailSVC = mainstoryboard.instantiateViewController(identifier: "FavorDetailViewController") as! FavorViewController
        let navs = self.nav
        detailSVC.favorpath = filterNews[indexPath.row]["path"] as? String
        navs?.pushViewController(detailSVC, animated: true)
    }
    
}
