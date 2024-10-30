//
//  CustomLayout.swift
//  COMMI
//
//  Created by Katerina Ivanova on 02.11.2023.
//

import UIKit

final class CustomLayout: UICollectionViewFlowLayout {
    
    let activeDistance: CGFloat = 200
    let zoomFactor: CGFloat = 0.3
    
    override init() {
        super.init()
        setUp()
    }
    
    private func setUp() {
        scrollDirection = .horizontal
        minimumLineSpacing = 45
    }
    
    private func getCollectionView() -> UICollectionView {
        guard let collectionView = collectionView else { fatalError("CollectionView is not present") }
        return collectionView
    }
    
    override func prepare() {
        let collectionView = getCollectionView()
        let width = collectionView.frame.width * 0.6
        let hieght = collectionView.frame.height * 0.7
        itemSize = CGSize(width: width, height: hieght)
        
        let verticalInsert = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom) / 2
        
        sectionInset = UIEdgeInsets(top: verticalInsert, left: 14, bottom: verticalInsert, right: 14)
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let collectionView = getCollectionView()
        let rectAttrs = super.layoutAttributesForElements(in: rect)!.map{$0.copy() as! UICollectionViewLayoutAttributes}
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
        
        for attr in rectAttrs where attr.frame.intersects(visibleRect) {
            let distance = visibleRect.midX - attr.center.x
            let normalizeDistance = distance / activeDistance
            
            if distance.magnitude < activeDistance {
                let zoom = 1 + zoomFactor * (1 - normalizeDistance.magnitude)
                attr.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                attr.zIndex = Int(zoom.rounded())
            }
        }
        return rectAttrs
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let collectionView = getCollectionView()
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        
        guard let rectAttr = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        
        for layoutAttributes in rectAttr {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let collectionView = getCollectionView()
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView.bounds.size
        return context
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
