//
//  ViewController.swift
//  Test
//
//  Created by Олег Савельев on 19.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var repositories: [Repository] = []
    var fetchingMore = false
    var urlNext = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loadingNib = UINib(nibName: "LoadCell", bundle: nil)
        self.tableView.register(loadingNib, forCellReuseIdentifier: "loadingCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Loader().loadRepo { repositories,url  in
            self.urlNext = url
            self.repositories = repositories
            self.tableView.reloadData()
        }

    }

 

}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return repositories.count
        } else if section == 1 && fetchingMore {
            return 1
        }
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
            let item = repositories[indexPath.row]
            cell.initCell(item: item)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell") as! LoadTableViewCell
            cell.activityIndicator.startAnimating()
            return cell
        }
 
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as! WebViewController
        vc.htmlUrl = repositories[indexPath.row].htmlUrl
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if contentHeight != 0{
            if offsetY > contentHeight - scrollView.frame.height {
                if !fetchingMore{
                    beginBatchFetch()
                }
                
            }
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        print("Load Next Page")
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            Loader().loadMoreRepo(url: self.urlNext, completion: { repositories,url in
                let newItem = repositories
                self.repositories.append(contentsOf: newItem)
                self.urlNext = url
                self.fetchingMore = false
                self.tableView.reloadData()
            })
            
        }
        }
    
}


