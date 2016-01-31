//
//  PuzzleBoardViewModel.swift
//  RACNest
//
//  Created by Rui Peres on 31/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import ReactiveCocoa

protocol PuzzleBoardDataSource {
    
    func configurePuzzbleBoard() -> SignalProducer<(PuzzlePieceViewModel, PuzzlePiecePosition), NoError>
}

final class PuzzleBoardViewModel {
    
    private let piecesModels: [(PuzzlePieceViewModel, PuzzlePiecePosition)]
    
    init(dimension: PuzzleBoardDimension, puzzlePieceSize: CGSize) {
        
        piecesModels = generatePuzzlePieces(dimension, pieceSize: puzzlePieceSize)
    }
}

extension PuzzleBoardViewModel: PuzzleBoardDataSource {
    
    func configurePuzzbleBoard() -> SignalProducer<(PuzzlePieceViewModel, PuzzlePiecePosition), NoError> {
        return SignalProducer(values: piecesModels)
    }
}

private func generatePuzzlePieces(dimension: PuzzleBoardDimension, pieceSize: CGSize) -> [(PuzzlePieceViewModel, PuzzlePiecePosition)] {
    
    var piecesViewModels: [(PuzzlePieceViewModel, PuzzlePiecePosition)] = []
    
    for i in 0..<dimension.numberOfRows {
        for j in 0..<dimension.numberOfColumns {
            
            let pieceViewModel = PuzzlePieceViewModel()
            piecesViewModels.append((pieceViewModel, PuzzlePiecePosition(row: i, column: j)))
        }
    }
    
    let randomIndex = Int(arc4random_uniform(UInt32(piecesViewModels.count)))
    piecesViewModels.removeAtIndex(randomIndex)
    
    return piecesViewModels
}
