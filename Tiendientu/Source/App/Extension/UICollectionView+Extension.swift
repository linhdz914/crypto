//
//  UICollectionView+Extension.swift
//  iStudy
//

import Foundation
import UIKit

protocol CollectionViewCellProtocol: AnyObject, ReuseID {
    associatedtype ViewModel

    func config(with viewModel: ViewModel, indexPath: IndexPath)
}

extension UICollectionView {
    func createCell<Cell, ViewModel>(_ type: Cell.Type, _ viewModel: ViewModel, _ indexPath: IndexPath) -> Cell
        where Cell: UICollectionViewCell, Cell: CollectionViewCellProtocol, Cell.ViewModel == ViewModel {
        let cell = dequeueReusableCell(withClass: Cell.self, for: indexPath)
        cell.config(with: viewModel, indexPath: indexPath)
        return cell
    }
    
    func customLeftAlignLayout(sectionInsets: UIEdgeInsets,
                               lineSpacing: CGFloat,
                               sectionSpacing: CGFloat) {
        let layout = UICollectionViewLeftAlignedLayout()
        layout.sectionInset = sectionInsets
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = sectionSpacing
        self.collectionViewLayout = layout
    }
}

// UICollectionView LeftAlignedLayout
final class UICollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var newAttributesArray = [UICollectionViewLayoutAttributes]()
        let superAttributesArray = super.layoutAttributesForElements(in: rect)!
        for (index, attributes) in superAttributesArray.enumerated() {
            if index == 0 || superAttributesArray[index - 1].frame.origin.y != attributes.frame.origin.y {
                attributes.frame.origin.x = sectionInset.left
            } else {
                let previousAttributes = superAttributesArray[index - 1]
                let previousFrameRight = previousAttributes.frame.origin.x + previousAttributes.frame.width
                attributes.frame.origin.x = previousFrameRight + minimumInteritemSpacing
            }
            newAttributesArray.append(attributes)
        }
        return newAttributesArray
    }
}
