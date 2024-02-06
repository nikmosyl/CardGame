//
//  Card.swift
//  CardGame
//
//  Created by nikita on 03.02.24.
//
import Foundation

struct GameTable {
    let success: Bool
    let deckId: String
    let remaining: Int
    let shuffled: Bool
    
    init(gameTableDetails: [String: Any]) {
        success = gameTableDetails["success"] as? Bool ?? false
        deckId = gameTableDetails["deck_id"] as? String ?? ""
        remaining = gameTableDetails["remaining"] as? Int ?? 0
        shuffled = gameTableDetails["shuffled"] as? Bool ?? false
    }
}

struct CardDeck {
    let success: Bool
    let deckId: String
    let cards: [Any]
    let remaining: Int
    
    init(cardDeskDetails: [String: Any]) {
        success = cardDeskDetails["success"] as? Bool ?? false
        deckId = cardDeskDetails["deck_id"] as? String ?? ""
        cards = cardDeskDetails["cards"] as? [Any] ?? []
        remaining = cardDeskDetails["remaining"] as? Int ?? 0
    }
}

struct Card {
    let code: String
    let image: String
    let value: String
    let suit: String
    
    init(cardDetails: [String: Any]) {
        code = cardDetails["code"] as? String ?? ""
        image = cardDetails["image"] as? String ?? ""
        value = cardDetails["value"] as? String ?? ""
        suit = cardDetails["suit"] as? String ?? ""
    }
}
