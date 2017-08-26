//
//  ImageCollectionViewController.swift
//  PatientManagement
//
//  Created by TuoTuo on 2017/8/20.
//  Copyright © 2017年 TuoTuo. All rights reserved.
//

import UIKit
import CHTCollectionViewWaterfallLayout

private let reuseIdentifier = "Cell"

class ImageCollectionViewController: UIViewController, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    lazy var collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(CHTCollectionViewWaterfallCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return collectionView
    }()
    
    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.images = FileHelper.readUnarchivedFiles()
        self.view.addSubview(self.collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateLayoutForOrientation(UIApplication.shared.statusBarOrientation)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { [weak self] (context) in
            let orientation = UIApplication.shared.statusBarOrientation
            self?.updateLayoutForOrientation(orientation)
        }, completion: nil)
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    func updateLayoutForOrientation(_ orientation: UIInterfaceOrientation) {
        (self.collectionView.collectionViewLayout as! CHTCollectionViewWaterfallLayout).columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3
    }
    
    @IBAction func AddPhoto(_ sender: UIBarButtonItem) {
        let controller = UIAlertController(title: "添加图片", message: nil, preferredStyle: .actionSheet)
        let albumAction = UIAlertAction(title: "从相册选取", style: .default) { (_) in
            PhotoHelper.openAlbum(controller: self)
        }
        let cameraAction = UIAlertAction(title: "拍照", style: .default) { (_) in
            PhotoHelper.openCamera(controller: self)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(albumAction)
        controller.addAction(cameraAction)
        controller.addAction(cancelAction)
        self.present(controller, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CHTCollectionViewWaterfallCell
        
        // Configure the cell
        cell.imageView.image = UIImage(contentsOfFile: self.images[indexPath.row])
        return cell
    }

    // MARK: CHTCollectionViewDelegateWaterfallLayout
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                                  sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 400)
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //获取选择的原图
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // 存储图片
        FileHelper.saveImageToUnarchived(image)
        // 刷新
        self.images = FileHelper.readUnarchivedFiles()
        self.collectionView.reloadData()
        //图片控制器退出
        picker.dismiss(animated: true, completion: nil)
    }
}
