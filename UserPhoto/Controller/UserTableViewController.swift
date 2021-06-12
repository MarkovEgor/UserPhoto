//
//  UserTableViewController.swift
//  UserPhoto
//
//  Created by Egor Markov on 6/11/21.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    // MARK: - Property
    
    var users: [User] = []
    var indexID: Int?
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        fechLodingData()
    }
    
    
    // MARK: - Func
    func fechLodingData() {
        NetWorkService.shared.fetchApiUser { userResult, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let user = userResult else {return}
            
            DispatchQueue.main.async {
                self.users = user
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    
    // MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userPhoto" {
            let viewController = segue.destination as? PhotoCollectionViewController
            viewController?.idUser = indexID
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = users[indexPath.row].id
        self.indexID = index
        performSegue(withIdentifier: "userPhoto", sender: nil)
    }
    
    
}


