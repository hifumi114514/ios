//
//  FavorTableViewController.swift
//  workf
//
//  Created by NICOLAS ENRICO. on 2021/6/7.
//

import UIKit
protocol AddItemDelegate {
    func addItem()
}
class FavorTableViewController: UITableViewController, AddItemDelegate {

    var searchResults:[[String:AnyObject]]?
    var searchcontroller: UISearchController!
    func addItem() {
    
        navigationController?.tabBarItem.badgeValue = "\(Favor.GetFavor().count)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Favor.initDB()
        searchResults = Favor.GetFavor()
        
        
        let xib = UINib(nibName:"NewsTableViewCell",bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "FavorCell")
        tableView.rowHeight = 210
        navigationController?.tabBarItem.badgeValue = "\(Favor.GetFavor().count)"
        
        
        initSearch()
        

    }

    
    // MARK: - Table view data source

    @IBOutlet weak var searchBar: UISearchBar!
    func initSearch(){
        let resultsController = SearchResultTableViewController()
        
        resultsController.nav = self.navigationController!
        resultsController.allNews = Favor.GetFavor()
        searchcontroller = UISearchController(searchResultsController: resultsController)
        let searchBar = searchcontroller.searchBar
        //searchBar.scopeButtonTitles = ["所有","姓名","地址"]
        searchBar.placeholder = "Enter a search item"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchcontroller.searchResultsUpdater = resultsController
        self.definesPresentationContext = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResults!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavorCell", for: indexPath)
        as! NewsTableViewCell
        cell.TittleLabel.text = Favor.GetFavor()[indexPath.row]["title"] as? String
        cell.TimeLabel.text = Favor.GetFavor()[indexPath.row]["passtime"]as? String
        
        /*//当下拉到底部，执行loadMore()
        if (indexPath.row == NewsManager.shared.news.count-1) {
            loadMore()
        }*/
        
        let iurl = URL(string: Favor.GetFavor()[indexPath.row]["image"]as! String)
        let data = try! Data(contentsOf: iurl!)
        cell.ImageShow.image = UIImage(data: data)
        return cell

    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Favor.Delete(title : Favor.GetFavor()[indexPath.row]["title"] as! String)
            searchResults?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            navigationController?.tabBarItem.badgeValue = "\(Favor.GetFavor().count)"
        }  
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("OK")
            let mainstoryboard = UIStoryboard(name:"Main",bundle: nil)
            let detailFVC = mainstoryboard.instantiateViewController(identifier: "FavorDetailViewController") as! FavorViewController
            let nav = self.navigationController
            detailFVC.favorpath = Favor.GetFavor()[indexPath.row]["path"] as? String
            nav?.pushViewController(detailFVC, animated: true)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        searchResults = Favor.GetFavor()
        tableView.reloadData()
    }
    

}
