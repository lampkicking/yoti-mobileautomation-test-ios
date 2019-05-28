//
//  HomeViewController.swift
//  automationqatest
//
//  Created by Casper Lee on 21/05/2019.
//  Copyright © 2019 Yoti Limited. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private enum ReuseIdenifier: CodingKey {
        case dataCell
    }
    
    private let items = ["area", "book", "business", "case", "child", "company",
                         "country", "day", "eye", "fact", "family", "government", "group", "hand", "home", "job",
                         "life", "lot", "man", "money", "month", "mother", "Mr", "night", "number", "part",
                         "people", "place", "point", "problem", "program", "question", "right", "room", "school",
                         "state", "story", "student", "study", "system", "thing", "time", "water", "way", "week",
                         "woman", "word", "work", "world"]
    
    @IBAction func logoutDidClick(_ sender: UIButton) {
        performSegue(withIdentifier: "logout", sender: self)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: ReuseIdenifier.dataCell.stringValue)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
