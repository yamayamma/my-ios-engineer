//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var SerchBar: UISearchBar!
    
    var repositories: [[String: Any]]=[]
    
    var task: URLSessionTask?
    var keyword: String!
    var url: String = ""
    var idx: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SerchBar.text = "GitHubのリポジトリを検索できるよー"
        SerchBar.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 初期テキストの削除
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        keyword = searchBar.text
        
        if !keyword.isEmpty {
            url = "https://api.github.com/search/repositories?q=\(keyword!)"
            task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
                if let obj = try? JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    if let items = obj["items"] as? [[String: Any]] {
                        self.repositories = items
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            // リスト更新
            task?.resume()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            let detail = segue.destination as! ViewController2
            detail.viewController1 = self
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let TableViewCell = UITableViewCell()
        let repository = repositories[indexPath.row]
        TableViewCell.textLabel?.text = repository["full_name"] as? String ?? ""
        TableViewCell.detailTextLabel?.text = repository["language"] as? String ?? ""
        TableViewCell.tag = indexPath.row
        return TableViewCell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        idx = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
    
}
