//
//  NetworkManager.swift
//  CardGame
//
//  Created by nikita on 03.02.24.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
        
    func fetchTable(from url: URL, completion: @escaping(Result<GameTable, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let table = GameTable(gameTableDetails: (value as? [String: Any] ?? [:])) 
                    completion(.success(table))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
    func fetchCardDeck(from url: String, completion: @escaping(Result<CardDeck, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let cards = CardDeck(cardDeskDetails: value as? [String : Any] ?? [:])
                    completion(.success(cards))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
