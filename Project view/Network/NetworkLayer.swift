//
//  NetworkLayer.swift
//  MovieLinkDemoTest
//
//  Created by Vijay Lal on 17/08/24.
//

import Foundation
class NetworkLayer: NetworkLayerProtocol {
    func callApi(url: String) async throws -> (Data, URLResponse)? {
        guard let unwrappedUrl = URL(string: url) else { return nil }
        return try await URLSession.shared.data(from: unwrappedUrl)
    }
}
