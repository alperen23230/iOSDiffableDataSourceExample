//
//  ViewController.swift
//  DiffableDataSourceExample
//
//  Created by Alperen Ünal on 25.10.2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    private var users = [User]()
    
    @UsesAutoLayout
    private var tableView = UITableView()
    
    private var dataSource: UITableViewDiffableDataSource<Section, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavBar()
        configureTableView()
        configureDataSource()
    }
    
    private func configureTableView(){
        tableView.delegate = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate(tableView.constraintsForAnchoringTo(boundsOf: view))
    }
    
    private func setNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let navigationBarItemAddImage = UIImage(systemName: "plus")?.withTintColor(.systemPurple, renderingMode: .alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:navigationBarItemAddImage, style: .plain, target: self, action: #selector(addItemToList))
        
        
        title = "Diffable List"
    }
    
    private func configureDataSource(){
        dataSource = UITableViewDiffableDataSource<Section, User>(tableView: tableView) {(tableView, indexPath, user) -> UITableViewCell? in
            let cell = UITableViewCell()
            cell.textLabel?.text = user.name
            return cell
        }
    }
    
    @objc private func addItemToList(){
        users.append(User(name: "Alperen"))
        createSnapshot(from: users)
    }
    
    private func createSnapshot(from addedUsers: [User]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.appendSections([.main])
        snapshot.appendItems(addedUsers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = dataSource.itemIdentifier(for: indexPath) else { return }
        print(user)
    }
    
    
}

extension ViewController {
    fileprivate enum Section {
        case main
    }
}

