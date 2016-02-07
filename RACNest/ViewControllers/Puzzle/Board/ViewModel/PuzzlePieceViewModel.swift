//
//  PuzzlePieceViewModel.swift
//  RACNest
//
//  Created by Rui Peres on 31/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

final class PuzzlePieceViewModel {
    
    let piecePosition: PuzzlePiecePosition
    let image: UIImage

    init(piecePosition: PuzzlePiecePosition, image: UIImage) {
        
        self.piecePosition = piecePosition
        self.image = image
    }
}