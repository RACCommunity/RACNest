//
//  PuzzleViewController.swift
//  RACNest
//
//  Created by Rui Peres on 31/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

final class PuzzleViewController: UIViewController {

    private let board = PuzzleBoard(dimension: PuzzleBoardDimension(numberOfRows: 3, numberOfColumns: 3))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(board)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        board.center = view.center
    }
}
