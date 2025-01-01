//
//  TrendAPIService.swift
//  Trendify.ai
//
//  Created by Darren Choe on 12/31/24.
//

import Foundation
import Combine

class TrendAPIService {
    func getTrends() -> AnyPublisher<[Trend], Error> {
        let url = URL(string: "https://api.example.com/trends")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Trend].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
