//
//  GitIssuesTableViewController.swift
//  Challenge_GitIssues
//
//  Created by Brenner on 06/06/20.
//  Copyright © 2020 Brenner. All rights reserved.
//

import UIKit


class GitIssuesTableViewController: UITableViewController {
    
    let alamofireServices = AlamofireServices()
    
    var issues: [Issue] = []
    
    let spinner = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.spinner.startAnimating()
        self.tableView.backgroundView = self.spinner
        
        alamofireServices.loadIssues(onSuccess: { (issues) in
            self.issues = issues
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
            }
        }) { (error) in
            let alert = UIAlertController(title: "Something happened :(", message: "Restart the application and try again!", preferredStyle: .alert)
            let doneButton = UIAlertAction(title: "Ok!", style: .default, handler: nil)
            alert.addAction(doneButton)
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return issues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        
        let issue = issues[indexPath.row]
        cell.textLabel?.text = issue.title
        if IssueStatus.closed.rawValue == issue.state{
            cell.detailTextLabel?.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        } else{
            cell.detailTextLabel?.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            
        }
        cell.detailTextLabel?.text = issue.state.uppercased()
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsPage" {
            
            let vc = segue.destination as! GitIssuesDetailsViewController
            vc.issue = issues[tableView.indexPathForSelectedRow!.row]
            
        }
    }
}
