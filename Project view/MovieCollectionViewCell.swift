//
//  MovieCollectionViewCell.swift
//  MovieLinkDemoTest
//
//  Created by Vijay Lal on 17/08/24.
//

import Foundation
import UIKit
class MovieCollectionViewCell: UICollectionViewCell {
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var MovieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MovieCollectionViewCell {
    private func initViews() {
        self.addSubview(thumbnailImageView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        [thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
         thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
         thumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
         thumbnailImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ].forEach( {$0.isActive = true} )
        self.addSubview(MovieNameLabel)
        MovieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        [MovieNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
         MovieNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
         MovieNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ].forEach( { $0.isActive = true })
    }
}
