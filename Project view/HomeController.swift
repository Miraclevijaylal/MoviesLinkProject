//
//  HomeController.swift
//  MovieLinkDemoTest
//
//  Created by Vijay Lal on 17/08/24.
//
import UIKit
import Combine
import SafariServices
class HomeController: UIViewController {
    
    var viewModel: HomeViewModel?
    lazy var viewLayouts: UICollectionViewFlowLayout = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.minimumLineSpacing = 10
        viewLayout.minimumInteritemSpacing = 10
        let requiredWidth = (self.view.bounds.width - 42) / 2
        viewLayout.itemSize = CGSize(width: requiredWidth, height: 1.4 * requiredWidth)
        viewLayout.scrollDirection = .vertical
        return viewLayout
    }()
    lazy var moviescollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: viewLayouts)
        view.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "ID")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    lazy var labelView: UILabel = {
        let label = UILabel()
        label.text = "Popular Movies"
        label.font = UIFont.systemFont(ofSize: 28, weight: .black)
        return label
    }()
    var cancellableSet: Set<AnyCancellable> = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        callApi()
        setupObservers()
    }
}
extension HomeController {
    func callApi() {
        Task.detached { [ weak self] in
            guard let unwrappedSelf = self else { return }
            await unwrappedSelf.viewModel?.getMovies()
        }
    }
    private func setupObservers() {
        viewModel?.MovieListPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self ] array in
                guard let unwrappedSelf = self else { return }
                unwrappedSelf.moviescollectionView.reloadData()
            }
        .store(in: &cancellableSet)
    }
}
extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.MoviesList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ID", for: indexPath) as! MovieCollectionViewCell
        cell.MovieNameLabel.text = viewModel?.MoviesList[indexPath.row].movie ?? ""
        cell.thumbnailImageView.backgroundColor = UIColor.random
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let imdbUrl = viewModel?.MoviesList[indexPath.row].imdb_url, let url = URL(string: imdbUrl) {
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController, animated: true)
        }
    }
}
extension HomeController {
    func initViews() {
        let guide = view.safeAreaLayoutGuide
        view.addSubview(labelView)
        view.backgroundColor = .white
        labelView.translatesAutoresizingMaskIntoConstraints = false
        [labelView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8),
         labelView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16)
        ].forEach({ $0.isActive = true })
        view.addSubview(moviescollectionView)
        moviescollectionView.translatesAutoresizingMaskIntoConstraints = false
        [moviescollectionView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 18),
         moviescollectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
         moviescollectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0),
         moviescollectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16)
        ].forEach({ $0.isActive = true })
    }
}
