//
//  PosterTableViewCell.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 22/11/22.
//

import UIKit

class PosterTableViewCell: UITableViewCell {

    static let identifier = "PosterTableViewCell"
    
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let posterTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImage)
        contentView.addSubview(posterTitle)
        contentView.addSubview(playButton)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with model: PosterViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterImageURL)") else { return }
        posterImage.sd_setImage(with: url, completed: nil)
        posterTitle.text = model.posterTitle
    }
    
    private func applyConstraints() {
        let posterImageConstraint = [
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            posterImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let posterTitleConstraint = [
            posterTitle.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 20),
            posterTitle.widthAnchor.constraint(equalToConstant: 150),
            posterTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        let playButtonConstraint = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ]
        
        NSLayoutConstraint.activate(posterImageConstraint)
        NSLayoutConstraint.activate(posterTitleConstraint)
        NSLayoutConstraint.activate(playButtonConstraint)
        
    }
    
}
