//
//  PuzzlePiece.swift
//  RACNest
//
//  Created by Rui Peres on 31/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

final class PuzzlePiece: UIView {
    
    private var puzzleImage: UIImageView = UIImageView()
    
    init(size: CGSize) {
        super.init(frame: CGRect(origin: CGPointZero, size: size))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage) {
        puzzleImage.image = image
    }
    
    override func layoutSubviews() {
        puzzleImage.center = center
    }
}
