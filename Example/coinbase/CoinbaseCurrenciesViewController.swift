//
//  CoinbaseCurrenciesViewController.swift
//  Example of unautheticated API usage and of APIs returning arrays
//

import UIKit

class CoinbaseCurrenciesViewController: UITableViewController, UITableViewDataSource {

    var currencies: [[String]]?

    override func viewDidAppear(animated: Bool) {

        // Load currencies
        Coinbase().doGet("currencies", parameters: [:]) {
            (response: AnyObject?, error: NSError?) in
            if let error = error {
                NSLog("Error: \(error)")
            } else {
                self.currencies = response as? [[String]]
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currencies = self.currencies {
            return currencies.count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("currency") as? UITableViewCell

        let label = cell?.viewWithTag(1) as? UILabel
        label?.text = currencies?[indexPath.row][0]

        return cell!
    }
}
