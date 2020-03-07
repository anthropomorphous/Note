import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = [UIImage]()
    var imageViews = [UIImageView]()
    var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        for image in images {
            let imageView = UIImageView(image: image)
            imageViews.append(imageView)
            scrollView.addSubview(imageView)
        }
    }
    
     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.isPagingEnabled = true
            
        for (index, imageView) in imageViews.enumerated() {
            imageView.frame.size = scrollView.frame.size
            imageView.frame.origin.x = scrollView.frame.width * CGFloat(index)
            imageView.frame.origin.y = 0
        }

        scrollView.contentSize.width = scrollView.frame.width * CGFloat(imageViews.count)
        scrollView.contentOffset.x = scrollView.frame.width * CGFloat(currentIndex!)
    }
}

extension GalleryViewController: UIScrollViewDelegate {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let pageIndex = (scrollView.contentOffset.x / scrollView.frame.width)
        currentIndex = Int(pageIndex.rounded())
    }
}
