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
    private var animator: PuzzleBoardAnimator

    var puzzleBoardLinesColor = UIColor.grayColor()
    var puzzleBoardBackgroudColor = UIColor.whiteColor()
    
    init(boardDimension: PuzzleBoardDimension, image: UIImage, puzzlePieceSize: CGSize = CGSize(width: 100, height: 100)) {
        
        self.boardDimension = boardDimension
        self.puzzlePieceSize = puzzlePieceSize
        self.dataSource = PuzzleBoardDataSource(image: image, dimension: boardDimension)
        self.animator = PuzzleBoardAnimator(dimension: boardDimension)
        
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
            .flatMap(.Latest, transform: animator.movePieceRandomly)
        
        piecesDataSource.start()
    }
    
    // MARK - Animation 
    
    private func pieceAnimation(pieceSize: CGSize) -> (PuzzlePiece, PuzzlePiecePosition) -> Void {
        
        return { (puzzlePiece, piecePosition) in
            
            UIView.animateWithDuration(0.3) {
                
                let newX = piecePosition.column * Int(pieceSize.width)
                let newY = piecePosition.row * Int(pieceSize.height)
                
                let newLocation = CGPoint(x: newX, y: newY)
                puzzlePiece.frame.origin = newLocation
            }
        }
    }
    
    // MARK: - Board Construction
    
    private func addPieces(viewModels: [PuzzlePieceViewModel], skippedPiece: PuzzlePiecePosition, puzzlePieceSize: CGSize) -> SignalProducer<([PuzzlePieceViewModel], PuzzlePiecePosition), NoError> {
        
        return SignalProducer {o, d in
            
            viewModels.forEach { viewModel in
                
                let animation = self.pieceAnimation(self.puzzlePieceSize)
                let piece = PuzzlePiece(size: puzzlePieceSize, moveAnimation: animation, viewModel: viewModel)
                self.addSubview(piece)
                
                piece.frame = CGRect(origin: piece.frame.origin, size: puzzlePieceSize)
            }
            
            o.sendNext((viewModels,skippedPiece))
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


