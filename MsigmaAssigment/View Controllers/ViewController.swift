//
//  ViewController.swift
//  MsigmaAssigment
//
//  Created by Aaditya Singh on 16/07/23.
//

import UIKit
import Combine
import AVFoundation
import AVKit

final class ViewController: DataLoadingVC {
        
    private var collectionView: UICollectionView!
    private let viewModel = MainViewModel()
    
    private var episodeCellRegistration: UICollectionView.CellRegistration<EpisodeCell, Video>!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Episodes"
        configureCollectionView()
        fetchData()
    }
    
    private func configureCollectionView() {
    
        let layout = createLayout()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        
        episodeCellRegistration = UICollectionView.CellRegistration { cell, indexPath, episode in
            cell.titleLabel.text = episode.title
            cell.subtitleLabel.text = episode.subtitle
            cell.imageView.image = UIImage(named: episode.fileName)
        }
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }

    private func fetchData() {
        showLoadingView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.dismissLoadingView()
            strongSelf.viewModel.fetchData()
            strongSelf.collectionView.reloadData()
        }
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let episode = viewModel.episodes[indexPath.row]
        return collectionView.dequeueConfiguredReusableCell(using: episodeCellRegistration, for: indexPath, item: episode)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = viewModel.episodes[indexPath.row].videoURL else {
            print("found nil in url")
            return
        }
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) { 
            playerViewController.player!.play()
        }
    }
    
}


