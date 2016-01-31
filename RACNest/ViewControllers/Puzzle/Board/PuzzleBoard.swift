//
//  PuzzleBoard.swift
//  RACNest
//
//  Created by Rui Peres on 31/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

struct PuzzleBoardDimension {
    let numberOfRows: Int
    let numberOfColumns: Int
}

final class PuzzleBoard: UIView {
    
    var puzzleBoardLinesColor = UIColor.grayColor()
    var puzzleBoardBackgroudColor = UIColor.whiteColor()

    private let puzzlePieceSize = CGSize(width: 100, height: 100)
    
    init(dimension: PuzzleBoardDimension) {
        
        let width = Int(puzzlePieceSize.width) * dimension.numberOfRows
        let height = Int(puzzlePieceSize.height) * dimension.numberOfColumns

        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        backgroundColor = puzzleBoardBackgroudColor
        
        self.defineBorder()
        self.definePuzzleSquares(dimension)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func defineBorder() {
        
        layer.borderColor = puzzleBoardLinesColor.CGColor
        layer.borderWidth = 1.0
    }
    
    private func definePuzzleSquares(dimension: PuzzleBoardDimension) {
        
        for i in 0..<dimension.numberOfColumns {
            
            let column = CALayer()
            let columnHeight = dimension.numberOfRows * Int(puzzlePieceSize.height)
            column.frame = CGRect(origin: CGPoint(x: i * Int(puzzlePieceSize.width), y: 0), size: CGSize(width: 1, height: columnHeight))
            
            column.backgroundColor = puzzleBoardLinesColor.CGColor
            layer.addSublayer(column)
        }
        
        for i in 0..<dimension.numberOfRows {
            
            let row = CALayer()
            let rownWidth = dimension.numberOfColumns * Int(puzzlePieceSize.width)
            row.frame = CGRect(origin: CGPoint(x: 0, y:  i * Int(puzzlePieceSize.width)), size: CGSize(width: rownWidth, height: 1))
            
            row.backgroundColor = puzzleBoardLinesColor.CGColor
            layer.addSublayer(row)
        }
    }
}
