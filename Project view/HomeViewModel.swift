//
//  HomeViewModel.swift
//  MovieLinkDemoTest
//
//  Created by Vijay Lal on 17/08/24.
//

import Foundation
import Combine
import UIKit
protocol HomeViewModelProtocol {
    func getMovies() async
    var MoviesList: [MovieModel] { get set }
    var MovieListPublisher: Published<[MovieModel]>.Publisher { get }
}
class HomeViewModel: HomeViewModelProtocol, ObservableObject {
    @Published var MoviesList: [MovieModel] = []
    var MovieListPublisher: Published<[MovieModel]>.Publisher { $MoviesList }
    var network: NetworkLayerProtocol?
    init(networkLayer: NetworkLayerProtocol?) {
        self.network = networkLayer
    }
    func getMovies() async {
        let url = String.baseUrl + String.MovieList
        Task.detached { [weak self] in
            guard let unwrappedSelf = self else { return }
            let responseData = try await unwrappedSelf.network?.callApi(url: url)
            do {
                if let unwrappedData = responseData?.0 {
                    let movieLists = try JSONDecoder().decode([MovieModel].self, from: unwrappedData)
                    unwrappedSelf.MoviesList = movieLists
                }
            } catch(_) {
                }
            }
        }
    }
