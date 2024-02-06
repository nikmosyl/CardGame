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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        fetchTable()
    }
    
    @IBAction func buttinAction() {
        if Int(label.text?.filter{ $0.isNumber } ?? "") ?? 0 > 0 {
            activityIndicator.startAnimating()
            fetchCard()
        }
    }
    
    private func fetchTable() {
        let url = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1")!
        networkManager.fetchTable(from: url) { [unowned self] result in
            switch result {
            case .success(let table):
                gameTable = table
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchCard() {
        guard let gameTable else { return }
        let url = "https://deckofcardsapi.com/api/deck/\(gameTable.deckId)/draw/?count=1"
        
        networkManager.fetchCardDeck(from: url) { [unowned self] result in
            switch result {
            case .success(let cardDeck):
                let card = Card(cardDetails: cardDeck.cards.first as? [String : Any] ?? [:])
                networkManager.fetchData(from: card.image) { [unowned self] result in
                    switch result {
                    case .success(let imageData):
                        cardView.image = UIImage(data: imageData)
                        label.text = "Осталось карт в колоде: \(cardDeck.remaining)"
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

