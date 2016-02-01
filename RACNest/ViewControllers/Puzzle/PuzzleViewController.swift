//
//  PuzzleViewController.swift
//  RACNest
//
//  Created by Rui Peres on 31/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit
import ReactiveCocoa

private let dimension =  PuzzleBoardDimension(numberOfRows: 3, numberOfColumns: 3)

final class PuzzleViewController: UIViewController {

    private let board = PuzzleBoard(boardDimension:dimension)
    private let viewModel: PuzzleViewModel = PuzzleViewModel(image: UIImage(named: "japan_forest")!, dimension: dimension)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(board)

        board.dataSource = viewModel
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        board.center = view.center
    }
}
