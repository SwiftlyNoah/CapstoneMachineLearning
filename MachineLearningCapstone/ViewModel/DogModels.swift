//
//  DogModels.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/16/21.
//

import Foundation

struct DogResult {
    var breed: String
    var probability: Int
}

struct DogResultsLogic {
    var clearWinner: DogResult?
    var tiedWinners: [DogResult]?
    var otherPossibilities: [DogResult]?
}

