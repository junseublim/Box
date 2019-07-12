//
//  PackageDetail2Cell.swift
//  
//
//  Created by Jun Seub Lim on 09/07/2019.
//

import UIKit

class PackageDetail2Cell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
{
    @IBOutlet var contentCell: UIView!
    
 @IBOutlet var packageDetailCV: UICollectionView!
    var imageList : [ProductInPackage]?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        packageDetailCV.delegate = self
        packageDetailCV.dataSource = self
        registerCVC()
        contentCell.setBorder(borderColor: UIColor.lightBlueGrey, borderWidth: 0.5)
    }

    func registerCVC() {
        let nibName = UINib(nibName: "PackageItemInsideCell", bundle: nil)
        packageDetailCV.register(nibName, forCellWithReuseIdentifier: "PackageItemInsideCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = packageDetailCV.dequeueReusableCell(withReuseIdentifier: "PackageItemInsideCell", for: indexPath) as! PackageItemInsideCell
        cell.packageItemName.text = imageList![indexPath.row].name
        
        cell.packageItemImage.imageFromUrl(imageList![indexPath.row].main_img)
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedFinalPrice = formatter.string(from: NSNumber(value: imageList![indexPath.row].price!))
        cell.packageItemPrice.text = formattedFinalPrice
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width: CGFloat = (self.frame.width) / 2
            //  let numOfRows = packageitems.count / 2
            let height = CGFloat(238)
            return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageList!.count
    }
    
    
}
