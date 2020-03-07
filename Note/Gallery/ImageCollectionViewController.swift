import UIKit

class ImageCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [UIImage]()
    let imagePicker = UIImagePickerController()

    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageNames = ["screen_1", "screen_2", "screen_3", "screen_4", "screen_5"]
        for name in imageNames {
            let image = UIImage(named: name)
                images.append(image!)
            }
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            if let galleryViewController = segue.destination as? GalleryViewController {
                if let index = sender as? Int {
                    galleryViewController.currentIndex = index
                }
                galleryViewController.images = images
                galleryViewController.hidesBottomBarWhenPushed = true
            }
        }
    }
}

extension ImageCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          performSegue(withIdentifier: "showImage", sender: indexPath.row)
      }
}

extension ImageCollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            images.append(pickedImage)
            collectionView.insertItems(at: [IndexPath(item: images.count - 1, section: 0)])
        }
        dismiss(animated: true, completion: nil)
    }
}
