//
//  PuzzleBoard.swift
//  RACNest
//
//  Created by Rui Peres on 31/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit
import ReactiveCocoa

struct PuzzleBoardDimension {
    let numberOfRows: Int
    let numberOfColumns: Int
}

final class PuzzleBoard: UIView {
    
    private let boardDimension: PuzzleBoardDimension
    private let puzzlePieceSize: CGSize
    private var dataSource: PuzzleBoardDataSource
    
    var puzzleBoardLinesColor = UIColor.grayColor()
    var puzzleBoardBackgroudColor = UIColor.whiteColor()
    
    init(boardDimension: PuzzleBoardDimension, image: UIImage, puzzlePieceSize: CGSize = CGSize(width: 100, height: 100)) {
        
        self.boardDimension = boardDimension
        self.puzzlePieceSize = puzzlePieceSize
        self.dataSource = PuzzleViewModel(image: image, dimension: boardDimension)
        
        let width = Int(puzzlePieceSize.width) * boardDimension.numberOfRows
        let height = Int(puzzlePieceSize.height) * boardDimension.numberOfColumns
        
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        backgroundColor = puzzleBoardBackgroudColor
        
        bootstrap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Board bootstrap
    
    private func bootstrap() {
        
        let piecesDataSource = dataSource.piecesViewModels
            .observeOn(QueueScheduler.mainQueueScheduler)
            .map { (viewModels, skippedPiece) in (viewModels, skippedPiece, self.puzzlePieceSize)}
            .flatMap(.Latest, transform: addPieces)
            .on(completed: { self.defineBoardBoundaries() })

        piecesDataSource.start()
    }
    
    // MARK: - Board Construction
    
    private func addPieces(viewModels: [PuzzlePieceViewModel], skippedPiece: PuzzlePiecePosition, puzzlePieceSize: CGSize) -> SignalProducer<([PuzzlePiece], PuzzlePiecePosition), NoError> {
        
        return SignalProducer {o, d in
            
            var puzzlePieces: [PuzzlePiece] = []
            
            viewModels.forEach { viewModel in
                
                let piece = PuzzlePiece(size: puzzlePieceSize, viewModel: viewModel)
                self.addSubview(piece)
                puzzlePieces.append(piece)
                
                let x = viewModel.piecePosition.row * Int(puzzlePieceSize.width)
                let y = viewModel.piecePosition.column * Int(puzzlePieceSize.height)
                piece.frame = CGRect(origin: CGPoint(x: x, y: y), size: puzzlePieceSize)
            }
            
            o.sendNext((puzzlePieces,skippedPiece))
            o.sendCompleted()
        }
    }
    
    private func defineBoardBoundaries()  {
        
        defineBorder()
        defineSquares()
    }
    
    private func defineBorder() {
        
        layer.borderColor = puzzleBoardLinesColor.CGColor
        layer.borderWidth = 1.0
    }
    
    private func defineSquares() {
        
        for i in 0..<boardDimension.numberOfColumns {
            
            let column = CALayer()
            let columnHeight = boardDimension.numberOfRows * Int(puzzlePieceSize.height)
            column.frame = CGRect(origin: CGPoint(x: i * Int(puzzlePieceSize.width), y: 0), size: CGSize(width: 1, height: columnHeight))
            
            column.backgroundColor = puzzleBoardLinesColor.CGColor
            layer.addSublayer(column)
        }
        
        for i in 0..<boardDimension.numberOfRows {
            
            let row = CALayer()
            let rownWidth = boardDimension.numberOfColumns * Int(puzzlePieceSize.width)
            row.frame = CGRect(origin: CGPoint(x: 0, y:  i * Int(puzzlePieceSize.width)), size: CGSize(width: rownWidth, height: 1))
            
            row.backgroundColor = puzzleBoardLinesColor.CGColor
            layer.addSublayer(row)
        }
    }
}


