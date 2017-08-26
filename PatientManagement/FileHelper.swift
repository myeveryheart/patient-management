//
//  FileHelper.swift
//  PatientManagement
//
//  Created by TuoTuo on 2017/8/20.
//  Copyright © 2017年 TuoTuo. All rights reserved.
//

import Foundation
import UIKit

class FileHelper {
    
    static let fileManager = FileManager.default
    static let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    static let cachesDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    
    static func readaArchivedFiles() -> Array<String> {
        let files = try! fileManager.contentsOfDirectory(atPath: documentsDirectory)
        return files
    }
    
    static func readUnarchivedFiles() -> Array<String> {
        let fileNames = try! fileManager.contentsOfDirectory(atPath: cachesDirectory)
        var pngFiles = [String]()
        for fileName in fileNames {
            if fileName.hasSuffix(".png") {
                let pngFile = cachesDirectory + "/" + fileName
                pngFiles.append(pngFile)
            }
        }
        return pngFiles
    }
    
    static func saveImage(_ image: UIImage, to: URL) {
        try! UIImagePNGRepresentation(image)!.write(to: to)
    }
    
    static func saveImageToUnarchived(_ image: UIImage) {
        let fileName = String(lround(Date().timeIntervalSince1970)) + ".png"
        saveImage(image, to: URL(fileURLWithPath: cachesDirectory).appendingPathComponent(fileName))
    }
}
