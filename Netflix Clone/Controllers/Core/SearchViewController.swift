//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 12/11/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var posters = [Poster]()
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search Movies..."
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .label
        navigationItem.searchController = searchController
        
        
        view.addSubview(discoverTable)
        
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        discoverMovies()
        searchController.searchResultsUpdater = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    private func discoverMovies() {
        APIService.shared.fetchData(urlPath: "/3/discover/movie", urlParams: "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") { [weak self] (result: Result<PosterResponse, APIError>) in
            switch result {
            case .success(let data):
                self?.posters = data.results
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.identifier, for: indexPath) as? PosterTableViewCell else {
            return UITableViewCell()
        }
        
        let poster = posters[indexPath.row]
        cell.configure(with: PosterViewModel(posterTitle: poster.original_name ?? poster.original_title ?? "Unkown", posterImageURL: poster.poster_path ?? ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let input = searchBar.text,
            !input.trimmingCharacters(in: .whitespaces).isEmpty,
            input.trimmingCharacters(in: .whitespaces).count >= 3,
            let resultController = searchController.searchResultsController as? SearchResultViewController else {
                return
            }
        
        guard let query = input.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        APIService.shared.fetchData(urlPath: "/3/search/movie", urlParams: "&query=\(query)") { (result: Result<PosterResponse, APIError>) in
            switch result {
            case .success(let data):
                resultController.posters = data.results
                DispatchQueue.main.async {
                    resultController.searchResultCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
