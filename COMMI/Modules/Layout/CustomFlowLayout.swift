//
//  CustomFlowLayout.swift
//  COMMI
//
//  Created by Katerina Dev on 28.10.24.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard
            let attributesArray = super.layoutAttributesForElements(in: rect),
            let collectionViewWidth = collectionView?.frame.width
        else { return nil }

        let itemWidth = collectionViewWidth / 2 - 25
        let evenRowOffset: CGFloat = 40
        let oddRowOffset: CGFloat = 80

        for attributes in attributesArray where attributes.representedElementCategory == .cell {
            let row = attributes.indexPath.row / 2
            let isEvenRow = row % 2 == 0
            let isFirstInRow = attributes.indexPath.item % 2 == 0
            let isTallCell = isEvenRow == isFirstInRow
            
            attributes.frame.size = CGSize(width: itemWidth, height: isTallCell ? 250 : 210)
            
            switch row {
            case 1:
                attributes.frame.origin.y -= evenRowOffset
            case 2...:
                attributes.frame.origin.y -= isTallCell ? oddRowOffset : evenRowOffset
            default:
                break
            }
        }

        return attributesArray
    }
}

