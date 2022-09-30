//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var IssuesLabel: UILabel!
    
    var viewController1: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repositories = viewController1.repositories[viewController1.idx]
        
        languageLabel.text = "Written in \(repositories["language"] as? String ?? "")"
        starsLabel.text = "\(repositories["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repositories["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repositories["forks_count"] as? Int ?? 0) forks"
        IssuesLabel.text = "\(repositories["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
        
    }
    
    func getImage(){
        
        let repositories = viewController1.repositories[viewController1.idx]
        
        titleLabel.text = repositories["full_name"] as? String
        
        if let owner = repositories["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)
                    DispatchQueue.main.async {
                        self.imageView.image = img
                    }
                }.resume()
            }
        }
        
    }
    
}
