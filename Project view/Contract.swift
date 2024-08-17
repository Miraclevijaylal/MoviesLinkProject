//
//  Contract.swift
//  MovieLinkDemoTest
//
//  Created by Vijay Lal on 17/08/24.
//

import Foundation
protocol NetworkLayerProtocol: AnyObject {
    func callApi(url: String)async throws -> (Data, URLResponse)?
}
