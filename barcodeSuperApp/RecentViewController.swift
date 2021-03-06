//
//  RecentViewController.swift
//  barcodeSuperApp
//
//  Created by Luigi Marrandino on 16/03/18.
//  Copyright © 2018 Luigi Marrandino. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class RecentViewController: UITableViewController, SideMenuItemContent {
    var recentProducts = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        recentProducts = DB.recentProducts()!
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openMenu(_ sender: Any) {
        showSideMenu()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        temp = dictionary[DB.recentProducts()![(tableView.indexPathForSelectedRow?.row)!]]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if !recentProducts.isEmpty {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
            return 1
        } else {
            emptyMessage(message: "You haven't scanned any product.", viewController: self)
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentProducts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentCell", for: indexPath)
        let product = dictionary[recentProducts[indexPath.row]]!
        cell.textLabel!.text = product.name
        return cell
    }

    func emptyMessage(message: String, viewController: RecentViewController) {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.sizeToFit()

        viewController.tableView.backgroundView = messageLabel;
        viewController.tableView.separatorStyle = .none;
    }
}
