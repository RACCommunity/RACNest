//
//  PuzzlePieceViewModel.swift
//  RACNest
//
//  Created by Rui Peres on 31/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

final class PuzzlePieceViewModel {
    
    let currentPiecePosition: MutableProperty<PuzzlePiecePosition>
    let originalPiecePosition: Property<PuzzlePiecePosition>
    let image: UIImage

    init(originalPiecePosition: PuzzlePiecePosition, image: UIImage) {
        
        self.originalPiecePosition = Property(value: originalPiecePosition)
        self.currentPiecePosition = MutableProperty(originalPiecePosition)
        self.image = image
    }
}
