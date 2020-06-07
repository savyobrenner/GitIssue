//
//  GitIssuesDetailsViewController.swift
//  Challenge_GitIssues
//
//  Created by Brenner on 06/06/20.
//  Copyright © 2020 Brenner. All rights reserved.
//

import UIKit


class GitIssuesDetailsViewController: UIViewController {
    
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbCreatedAt: UILabel!
    @IBOutlet weak var lbBy: UILabel!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    
    var userHtmlUrl: String!
    var issueHtmlUrl: String!
    var issue: Issue!
    let alamofireServices = AlamofireServices()

    override func viewDidLoad() {
        super.viewDidLoad()
        renderDetails()
    }
    
    
    @IBAction func openOnNavigator(_ sender: Any) {
        UIApplication.shared.open(URL(string: issue.htmlUrl)!, options: [:], completionHandler: nil)
    }
    
    @IBAction func goAuthorProfile(_ sender: Any) {
        UIApplication.shared.open(URL(string: issue.user.htmlUrl)!, options: [:], completionHandler: nil)

    }
    
    func formatDate(date: String) -> String {
         let formatter = DateFormatter()
         formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
         formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         let date = formatter.date(from: date)!
         formatter.dateFormat = "dd/MM/yyyy"
         formatter.locale = Locale(identifier: "pt-BR") // reset the locale
         let dateString = formatter.string(from: date)
         return dateString
     }
    
    func loadAvatar(){
        aiLoading.startAnimating()
        alamofireServices.loadAvatar(imageUrl: issue.user.avatarUrl) { (image) in
            DispatchQueue.main.async {
            self.ivAvatar.image = image
                self.aiLoading.stopAnimating()
                self.aiLoading.isHidden = true
            }
        }
    }
    private func renderDetails(){
        loadAvatar()
        lbTitle.text = issue.title
        tvDescription.text = issue.body
        lbBy.text = "By " + issue.user.login
        lbCreatedAt.text = "Created at: " + formatDate(date: issue.createdAt)
    }
    
    
}
