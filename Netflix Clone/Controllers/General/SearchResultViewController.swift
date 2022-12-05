//
//  SearchResultViewController.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 26/11/22.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func SearchResultViewControllerDidTapItem(_ viewModel: PosterPreview)
}

class SearchResultViewController: UINavigationController {
    
    var posters = [Poster]()
    public weak var delegates: SearchResultViewControllerDelegate?

    let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: SectionCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
    
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as? SectionCollectionViewCell else { return UICollectionViewCell() }
        
        let poster = posters[indexPath.row]
        cell.configure(with: poster.poster_path ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let poster = posters[indexPath.row]
        guard let title = poster.original_title ?? poster.original_name else { return }
        guard let query = "\(title) trailer".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        APIService.shared.fetchData(useYoutubeAPI: true, urlPath: "/search", urlParams: "&q=\(query)") { [weak self] (result: Result<YoutubeSearchResponse, APIError>) in
            switch result {
            case .success(let response):
                self?.delegates?.SearchResultViewControllerDidTapItem(PosterPreview(
                    title: title,
                    overview: poster.overview ?? "",
                    youtubeView: response.items[0].id))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    
}
