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
        let files = try! fileManager.contentsOfDirectory(atPath: cachesDirectory)
        return files
    }
    
    static func saveImage(_ image: UIImage) {
        
    }
}
