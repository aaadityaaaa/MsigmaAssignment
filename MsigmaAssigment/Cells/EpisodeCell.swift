//
//  EpisodeCell.swift
//  MsigmaAssigment
//
//  Created by Aaditya Singh on 16/07/23.
//

import UIKit

class EpisodeCell: UICollectionViewCell {
    static let reuseIdentifier = "EpisodeCell"
    
     lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
     lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let imageView = RemoteImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 3
        
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        
        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStack.axis = .vertical
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        
        let horizontalStack = UIStackView(arrangedSubviews: [imageView, textStack])
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.spacing = 10
        
        contentView.addSubview(horizontalStack)
        
        imageView.constrainWidth(equalTo: 150)
        imageView.setAspectRatio(to: 1.6)
        horizontalStack.pin(edges: .top(padding: 8), .leading(padding: 8), .trailing(padding: -8), .bottom(padding: -8))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.cancelImageRequest()
        imageView.image = nil
    }
}

