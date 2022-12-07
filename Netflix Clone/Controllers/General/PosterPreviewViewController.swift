//
//  PosterPreviewViewController.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 03/12/22.
//

import UIKit
import WebKit

class PosterPreviewViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let posterTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let webView: WKWebView = {
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(viewContainer)
        
        viewContainer.addSubview(posterTitle)
        viewContainer.addSubview(overviewLabel)
        viewContainer.addSubview(downloadButton)
        viewContainer.addSubview(webView)
        
        configureConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()   
        let contentViewSize = CGSize(width: view.frame.width, height: self.view.frame.height)
        scrollView.frame = view.bounds
        scrollView.contentSize = viewContainer.frame.size
        scrollView.contentSize = contentViewSize
        viewContainer.frame.size = contentViewSize
    }
    
    func configure(with model: PosterPreview) {
        posterTitle.text = model.title
        overviewLabel.text = model.overview
        
        guard let url = URL(string: "https://youtube.com/embed/\(model.youtubeView.videoId)") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    private func configureConstraints() {
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        viewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            webView.leftAnchor.constraint(equalTo: viewContainer.leftAnchor),
            webView.rightAnchor.constraint(equalTo: viewContainer.rightAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let posterTitleConstraints = [
            posterTitle.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            posterTitle.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 20)
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: posterTitle.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: viewContainer.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: viewContainer.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(posterTitleConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }

}
