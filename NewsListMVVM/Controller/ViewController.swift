//
//  ViewController.swift
//  NewsListMVVM
//
//  Created by shree on 10/01/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var tblView: UITableView!
    private var newsArrayViewModel: NewsListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setUp()
        anotherSetUp()
    }
    private func setUp(){
        WebServices.getAllNews { (news) in
            guard let safeNews = news else { return }
            self.newsArrayViewModel = NewsListViewModel(newsArray: safeNews)
            self.reloadTable()
        }
    }
    private func anotherSetUp(){
        WebServices().loadAllNews(resources: NewsListViewModel.getAllNews()) { result in
            switch result {
            case .failure(let error):
                print("\(error.localizedDescription)")
            case .success(let data):
                print("data is \(data)")
                self.newsArrayViewModel = NewsListViewModel(newsArray: data.articles)
                self.reloadTable()
            }
        }
    }
    private func reloadTable(){
        DispatchQueue.main.async {
            
            self.tblView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsArrayViewModel == nil ? 0: newsArrayViewModel.noOfSection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArrayViewModel?.noOFRowsinSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath)as? NewsTableViewCell else { return UITableViewCell() }
        cell.setUpCell(news: self.newsArrayViewModel.newsAtIndex(index: indexPath.row))
        return cell
    }
}
