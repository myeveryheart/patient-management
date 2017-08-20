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

class ImageCollectionViewController: UIViewController, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout, UIImagePickerControllerDelegate {

    lazy var collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 0
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
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
        
        //图片控制器退出
        picker.dismiss(animated: true, completion: nil)
    }
}
