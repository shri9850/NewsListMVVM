//
//  NewsTableViewCell.swift
//  NewsListMVVM
//
//  Created by shree on 10/01/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var descriptionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(news: NewsViewModel) {
        self.titleLbl.text = news.title
        self.descriptionLbl.text = news.description
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
