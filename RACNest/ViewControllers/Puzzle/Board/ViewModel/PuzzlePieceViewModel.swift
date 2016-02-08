//
//  PuzzlePieceViewModel.swift
//  RACNest
//
//  Created by Rui Peres on 31/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit
import ReactiveCocoa

final class PuzzlePieceViewModel {
    
    let currentPiecePosition: MutableProperty<PuzzlePiecePosition>
    let originalPiecePosition: ConstantProperty<PuzzlePiecePosition>
    let image: UIImage

    init(originalPiecePosition: PuzzlePiecePosition, image: UIImage) {
        
        self.originalPiecePosition = ConstantProperty(originalPiecePosition)
        self.currentPiecePosition = MutableProperty(originalPiecePosition)
        self.image = image
    }
}