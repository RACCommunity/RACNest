//
//  PuzzlePiece.swift
//  RACNest
//
//  Created by Rui Peres on 31/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit
import UIKit

final class PuzzlePiece: UIView {
    
    private let puzzleImage: UIImageView = UIImageView()
    private let viewModel: PuzzlePieceViewModel
    
    init(size: CGSize, viewModel: PuzzlePieceViewModel) {
        
        self.viewModel = viewModel
        super.init(frame: CGRect(origin: CGPointZero, size: size))
        
        viewModel.image.producer.startWithNext {[weak self] image in
            self?.puzzleImage.image = image
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        puzzleImage.center = center
    }
}
