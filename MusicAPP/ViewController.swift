//
//  ViewController.swift
//  MusicAPP
//
//  Created by Alibek Kozhambekov on 01.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let networkService = NetworkService()

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchBar()
        
        let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=5"
        
//        request(urlString: urlString) { searchResponse, error in
//            searchResponse?.results.map({ (track) in
//                print(track.trackName)
//            })
//        }
        
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let searchResponse):
                searchResponse.results.map { (track) in
                    print("track.trackName:", track.trackName)
                }
            case .failure(let error):
                print("error:", error)
            }
        }
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "123"
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
