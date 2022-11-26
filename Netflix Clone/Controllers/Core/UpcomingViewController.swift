//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 12/11/22.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var posters = [Poster]()

    private let upcomingTable: UITableView = {
        let table = UITableView()
        table.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcomingMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func fetchUpcomingMovies() {
        APIService.shared.fetchData(urlPath: "/3/movie/upcoming", urlParams: "&language=en-US&page=1") { [weak self] (result: Result<PosterResponse, APIError>) in
            switch result {
            case.success(let data):
                self?.posters = data.results
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.identifier, for: indexPath) as? PosterTableViewCell else { return UITableViewCell() }
        let poster = posters[indexPath.row]
        cell.configure(with: PosterViewModel(posterTitle: poster.original_title ?? poster.original_name ?? "Unkown", posterImageURL: poster.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
