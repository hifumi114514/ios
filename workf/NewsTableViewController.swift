//
//  NewsTableViewController.swift
//  workf
//
//  Created by 周子康 on 2021/5/27.
//

import UIKit

class NewsTableViewController: UITableViewController {

    //var news:[[String:String]] = [["":""]]
    let jasonClass = NewsManager(filename: "News")
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setRefreshView()
        setMoreView()
        loadMore()
        jasonClass.Load()
        let xib = UINib(nibName:"NewsTableViewCell",bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "NewsCell")
        tableView.rowHeight = 210
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        /*let url = URL(string:"http://zy.whu.edu.cn/news/api/news/getList?page=1&count=10")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let jasonobj = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
               let jsn = jasonobj as? [String:Any]{
                let news_result = jsn["result"] as! [[String : String]]
                self.news = news_result
            } }
        task.resume()*/
    }

    //上拉刷新视图
    func setMoreView() {
        let loadMoreView = UIView(frame: CGRect(x:0, y:self.tableView.contentSize.height,width:self.tableView.bounds.size.width, height:60))
        loadMoreView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        loadMoreView.backgroundColor = self.tableView.backgroundColor
        
        //添加中间的环形进度条
        let indicator = UIActivityIndicatorView()
        //indicator.color = UIColor.darkGray
        let indicatorX = self.view.frame.width/2-indicator.frame.width/2
        let indicatorY = loadMoreView.frame.size.height/2-indicator.frame.height/2
        indicator.frame = CGRect(x:indicatorX, y:indicatorY, width:indicator.frame.width, height:indicator.frame.height)
        indicator.startAnimating()
        loadMoreView.addSubview(indicator)
        self.tableView.tableFooterView = loadMoreView
    }
    
    func setRefreshView()
    {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        self.refreshData()
    }
    
    // 刷新数据
    @objc func refreshData() {
        NewsManager.shared.refresh{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.refreshControl!.endRefreshing()
    }
    
    
    
    //加载更多数据
    func loadMore(){
        print("加载新数据！")
        NewsManager.shared.fetchMore {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
 

     
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? NewsViewController
        {
            dest.news = NewsManager.shared.news[ tableView.indexPathForSelectedRow!.row]
        }
    }*/
 
    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return NewsManager.shared.news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        as! NewsTableViewCell
        cell.TittleLabel.text = NewsManager.shared.news[indexPath.row].title
        cell.TimeLabel.text = NewsManager.shared.news[indexPath.row].passtime
        
        //当下拉到底部，执行loadMore()
        if (indexPath.row == NewsManager.shared.news.count-1) {
            loadMore()
        }
        
        let iurl = URL(string: NewsManager.shared.news[indexPath.row].image)
        let data = try! Data(contentsOf: iurl!)
        cell.ImageShow.image = UIImage(data: data)
        return cell
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? DetailViewController
        {
            dest.newsweb = NewsManager.shared.news[tableView.indexPathForSelectedRow!.row]
        }
    }
 */
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let mainstoryboard = UIStoryboard(name:"Main",bundle: nil)
            let detailVC = mainstoryboard.instantiateViewController(identifier: "NewsDetail") as! DetailViewController
        
            let nav = self.navigationController
            detailVC.newsweb = NewsManager.shared.news[indexPath.row]
            nav?.pushViewController(detailVC, animated: true)
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
