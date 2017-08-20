//
//  PhotoHelper.swift
//  PatientManagement
//
//  Created by TuoTuo on 2017/8/20.
//  Copyright © 2017年 TuoTuo. All rights reserved.
//

import Foundation
import UIKit

class PhotoHelper {
    
    //打开相册
    static func openAlbum(controller: UIViewController){
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = controller as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            //指定图片控制器类型
            picker.sourceType = .photoLibrary
            //设置是否允许编辑
            //            picker.allowsEditing = editSwitch.on
            //弹出控制器，显示界面
            controller.present(picker, animated: true, completion: nil)
        }else{
            debugPrint("读取相册错误")
        }
    }
    
    //打开相机
    static func openCamera(controller: UIViewController){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //创建图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = controller as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            //设置来源
            picker.sourceType = .camera
            //允许编辑
//            picker.allowsEditing = true
            //打开相机
            controller.present(picker, animated: true, completion: nil)
        }else{
            debugPrint("找不到相机")
        }
    }
}
