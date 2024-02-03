//
//  Card.swift
//  CardGame
//
//  Created by nikita on 03.02.24.
//
import Foundation

struct GameTable: Decodable {
    let success: Bool
    let deckId: String
    let remaining: Int
    let shuffled: Bool
}

struct CardDeck: Decodable {
    let success: Bool
    let deckId: String
    let cards: [Card]
    let remaining: Int
}

struct Card: Decodable {
    let code: String
    let image: URL
    let value: String
    let suit: String
}
