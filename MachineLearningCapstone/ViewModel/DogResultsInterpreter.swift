//
//  DogResultsInterpreter.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/16/21.
//

import Foundation

class DogResultsInterpreter {
    
    static let shared = DogResultsInterpreter()
    
    private init () {}
    
    func determineProbabilities(results: [DogResult]) -> DogResultsLogic {
        var highChances = [DogResult]()
        var lowChances = [DogResult]()
        
        for result in results {
            if result.probability >= 40 {
                highChances.append(result)
            }
            else {
                lowChances.append(result)
            }
        }
        
        return DogResultsLogic(clearWinner: highChances.count == 1 ? highChances[0] : nil, tiedWinners: highChances.count > 1 ? highChances : nil, otherPossibilities: lowChances.count > 0 ? lowChances : nil)
    }
    
}

