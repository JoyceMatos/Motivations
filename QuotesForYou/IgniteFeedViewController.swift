//
//  igniteFeedViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 2/22/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class IgniteFeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let igniteCell = IgniteTableViewCell()
    let firebaseManager = FirebaseManager.shared
    var content = [Quote]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 189

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firebaseManager.createQuote { (quoteID, quote, author) in
            print("HELLLOOOOO")
            var quote = Quote(with: quoteID, quote: quote, author: author)
            self.content.append(quote)
            print(quote.quote)
            
            //TODO: - Display content as a stack (most recent on top)
            self.tableView.reloadData()

        }
        
        tableView.reloadData()

    }
    
    // MARK: - Action methods
//    func flagQuote(_ quote: String) {
//        firebaseManager.flagQuote(quote)
//    }
    
    
    // TODO: - Change header to "Explore what keeps others motivated"

}




// MARK:- TableView methods

extension IgniteFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quote = content[indexPath.row]
        let cell = Bundle.main.loadNibNamed("IgniteTableViewCell", owner: self, options: nil)?.first as! IgniteTableViewCell
        
        
        cell.quote = quote
        
        cell.quoteLabel.sizeToFit()
        cell.authorLabel.sizeToFit()
        cell.quoteLabel.text = cell.quote.quote?.description
        cell.authorLabel.text = cell.quote.author?.description
  
        
        return cell
    }
    
    func flagTapped(_ sender: UIButton) {
        
        
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}

