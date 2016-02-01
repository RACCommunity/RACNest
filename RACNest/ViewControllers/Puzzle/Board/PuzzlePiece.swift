//
//  PuzzlePiece.swift
//  RACNest
//
//  Created by Rui Peres on 31/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit
import ReactiveCocoa

struct PuzzlePiecePosition {
    
    let row: Int
    let column: Int
}

extension PuzzlePiecePosition: Hashable {
    
    var hashValue: Int {
        return "\(row),\(column)".hash
    }
}

func ==(lhs: PuzzlePiecePosition, rhs: PuzzlePiecePosition) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

final class PuzzlePiece: UIView {
    
    private let puzzleImageView: UIImageView = UIImageView()
    private let viewModel: PuzzlePieceViewModel
    
    init(size: CGSize, viewModel: PuzzlePieceViewModel) {
        
        self.viewModel = viewModel
        super.init(frame: CGRect(origin: CGPointZero, size: size))
        
        addSubview(puzzleImageView)
        self.puzzleImageView.image = viewModel.image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        puzzleImageView.frame = bounds
    }
}
