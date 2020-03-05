//
//  GalleryViewController.swift
//  Note
//
//  Created by ios_school on 3/5/20.
//  Copyright © 2020 ios_school. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageViews = [UIImageView]()

    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageNames = ["screen_1", "screen_2", "screen_3", "screen_4", "screen_5"]
        for name in imageNames {
            let image = UIImage(named: name)
                let imageView = UIImageView(image: image)
                
                imageView.contentMode = .scaleAspectFit
                imageView.clipsToBounds = true
                
                scrollView.addSubview(imageView)
                
                imageViews.append(imageView)
            }
        
        pageControl.numberOfPages = imageNames.count
        pageControl.currentPage = 0
    }
    
     override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            scrollView.isPagingEnabled = true
            
            for (index, imageView) in imageViews.enumerated() {
                imageView.frame.size = scrollView.frame.size
                imageView.frame.origin.x = scrollView.frame.width * CGFloat(index)
                imageView.frame.origin.y = 0
            }
            
            let contentWidth = scrollView.frame.width * CGFloat(imageViews.count)
            scrollView.contentSize = CGSize(width: contentWidth,
                                            height: scrollView.frame.height)
        }
        
        @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
            let offset = scrollView.frame.width * CGFloat(pageControl.currentPage)
            scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }

}

extension GalleryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = (scrollView.contentOffset.x / scrollView.frame.width)
        let roundedPageIndex = Int(round(Double(pageIndex)))
        pageControl.currentPage = roundedPageIndex
    }
}
