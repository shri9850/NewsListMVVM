//
//  NewsViewModel.swift
//  NewsListMVVM
//
//  Created by shree on 10/01/22.
//

import Foundation
struct NewsViewModel {
    let news: News
    init(_ news: News) {
        self.news = news
    }
    
    var title: String{
        self.news.title ?? ""
    }
    
    var description: String{
        self.news.description ?? ""
    }
}
struct NewsListViewModel {
    let newsArray:[News]
}

extension NewsListViewModel{
    
    var noOfSection: Int{
        return 1
    }
    
    func noOFRowsinSection(section: Int)-> Int{
        return self.newsArray.count
    }
    
    func newsAtIndex(index: Int) -> NewsViewModel {
        let newsViewModel = NewsViewModel(newsArray[index])
        return newsViewModel
    }
}

struct MapNewsListViewModel {
    var newList: [NewsViewModel]
    
    init() {
        self.newList = [NewsViewModel]()
    }
}

extension NewsListViewModel{
    
    static func getAllNews()-> Resources<NewsModel>{
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=51d8f9dad8f74ff7829e090593b329bf") else { fatalError()}
        return Resources<NewsModel>(url: url)
    }
}
