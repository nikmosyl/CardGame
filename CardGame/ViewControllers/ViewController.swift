//
//  ViewController.swift
//  CardGame
//
//  Created by nikita on 03.02.24.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var cardView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let networkManager = NetworkManager.shared
    private var gameTable: GameTable?
    private var cardBalance: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        fetchDesk()
    }
    
    @IBAction func buttinAction() {
        if Int(label.text?.filter{ $0.isNumber } ?? "") ?? 0 > 0 {
            activityIndicator.startAnimating()
        }
        fetchCard()
    }
    
    private func fetchDesk() {
        let url = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1")!
        networkManager.fetch(GameTable.self, from: url) { [unowned self] result in
            switch result {
            case .success(let desk):
                gameTable = desk
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchCard() {
        guard let gameTable else { return }
        let url = URL(string: "https://deckofcardsapi.com/api/deck/\(gameTable.deckId)/draw/?count=1")!
        networkManager.fetch(CardDeck.self, from: url) { [unowned self] result in
            switch result {
            case .success(let cardDesk):
                guard let card = cardDesk.cards.first else { return }
                let cardUrl = card.image
                networkManager.fetchImage(from: cardUrl) { [unowned self] result in
                    switch result {
                    case .success(let imageData):
                        cardView.image = UIImage(data: imageData)
                        label.text = "Осталось карт в колоде: \(cardDesk.remaining)"
                        activityIndicator.stopAnimating()
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

