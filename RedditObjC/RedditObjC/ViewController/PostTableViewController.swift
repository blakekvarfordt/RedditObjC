//
//  PostTableViewController.swift
//  RedditObjC
//
//  Created by Blake kvarfordt on 8/21/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController, UISearchBarDelegate {

    private let cellID = "PostCell"
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var posts = [BTKPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = self.searchBar.text, !searchTerm.isEmpty else { return }
        
        let searchString = searchTerm.replacingOccurrences(of: " ", with: "+")
        
        searchBar.resignFirstResponder()
        
        // Closures can capture strong reference cycles, a reference cycle that cant properly deallocate.
        BTKPostController.shared().searchForPost(withSearchTerm: searchString) { [weak self] (posts, error) in
            
            guard let self = self else { return }
            
            self.posts = posts
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                searchBar.text = ""
                
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }

        let post = posts[indexPath.row]
        
        cell.titleLabel.text = post.title
        cell.upsLabel.text = "Ups \(post.ups) 🤙 "
        cell.commentCountLabel.text = "\(post.commentCount)"

        
        
        BTKPostController.shared().fetchThumbnailPost(post, completion: { (image) in
            DispatchQueue.main.async {
                cell.postImageView.image = image
            }
        }) 

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
