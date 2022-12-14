//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 12/11/22.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    let sectionTitles = ["Trending Movies", "Trending Tv", "Popular", "Upcoming Movies", "Top Rated"]
    
    private var headerView: HeroHeaderUIView?
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        configureHeroHeaderView()
     }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureHeroHeaderView() {
        APIService.shared.fetchData(urlPath: "/3/trending/movie/week") { [weak self] (result: Result<PosterResponse, APIError>) in
            switch result {
            case .success(let response):
                let randomMovie = response.results.randomElement()
                self?.headerView?.configure(with: PosterViewModel(
                    posterTitle: randomMovie?.original_title ?? randomMovie?.original_name ?? "",
                    posterImageURL: randomMovie?.poster_path ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureNavbar() {
        var image = UIImage(named: "NetflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .plain, target: self, action: nil),
        ]
        navigationController?.navigationBar.tintColor = .label
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18)
        header.textLabel?.frame = CGRect(
            x: header.bounds.origin.x + 20,
            y: header.bounds.origin.y,
            width: 100,
            height: header.bounds.height
        )
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APIService.shared.fetchData(urlPath: "/3/trending/movie/week") { (result: Result<PosterResponse, APIError>) in
                switch result {
                case .success(let data):
                    cell.configure(with: data.results)
                case .failure(let error):
                    print("fetch error: \(error.localizedDescription)")
                }
            }

        case Sections.TrendingTv.rawValue:
            APIService.shared.fetchData(urlPath: "/3/trending/tv/week") { (result: Result<PosterResponse, APIError>) in
                switch result {
                case .success(let data):
                    cell.configure(with: data.results)
                case .failure(let error):
                    print("fetch error: \(error.localizedDescription)")
                }
            }
            
        case Sections.Popular.rawValue:
            APIService.shared.fetchData(urlPath: "/3/movie/popular", urlParams: "&languange=en-US&page=1") { (result: Result<PosterResponse, APIError>) in
                switch result {
                case .success(let data):
                    cell.configure(with: data.results)
                case .failure(let error):
                    print("fetch error: \(error.localizedDescription)")
                }
            }
            
        case Sections.Upcoming.rawValue:
            APIService.shared.fetchData(urlPath: "/3/movie/upcoming", urlParams: "&languange=en-US&page=1") { (result: Result<PosterResponse, APIError>) in
                switch result {
                case .success(let data):
                    cell.configure(with: data.results)
                case .failure(let error):
                    print("fetch error: \(error.localizedDescription)")
                }
            }
            
        case Sections.TopRated.rawValue:
            APIService.shared.fetchData(urlPath: "/3/movie/top_rated", urlParams: "&languange=en-US&page=1") { (result: Result<PosterResponse, APIError>) in
                switch result {
                case .success(let data):
                    cell.configure(with: data.results)
                case .failure(let error):
                    print("fetch error: \(error.localizedDescription)")
                }
            }
            
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaulOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaulOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, model: PosterPreview) {
        DispatchQueue.main.async { [weak self] in
            let vc = PosterPreviewViewController()
            vc.configure(with: model)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
