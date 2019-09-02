//
//  UIImage+Extension.swift
//  GICXmlTest
//
//  Created by ld on 2019/1/7.
//  Copyright © 2019 cm. All rights reserved.
//
import Foundation

extension UIImage {
    /**
     缩放图片到指定Size
     */
    public func scaleImage(with size: CGSize) -> UIImage? {
        //创建上下文
        UIGraphicsBeginImageContextWithOptions(size, _: true, _: scale)
        //绘图
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        //获取新图片
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    /**
     按比例缩放图片，scale就是缩放比例
     */
    public func scaleImage(withScale scale: CGFloat) -> UIImage? {
        if scale < 0 {
            return self
        }
        let scaleSize = CGSize(width: size.width * scale, height: size.height * scale)
        return scaleImage(with: scaleSize)
    }
    
    //将图片缩放成指定尺寸（多余部分自动删除）
    public func scaled(to newSize: CGSize) -> UIImage {
        //计算比例
        let aspectWidth  = newSize.width/size.width
        let aspectHeight = newSize.height/size.height
        let aspectRatio = max(aspectWidth, aspectHeight)
        //图片绘制区域
        var scaledImageRect = CGRect.zero
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = (newSize.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y    = (newSize.height - size.height * aspectRatio) / 2.0
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    
    //将图片裁剪成指定比例（多余部分自动删除）
    public func crop(ratio: CGFloat) -> UIImage {
        //计算最终尺寸
        var newSize:CGSize!
        if size.width/size.height > ratio {
            newSize = CGSize(width: size.height * ratio, height: size.height)
        }else{
            newSize = CGSize(width: size.width, height: size.width / ratio)
        }
        ////图片绘制区域
        var rect = CGRect.zero
        rect.size.width  = size.width
        rect.size.height = size.height
        rect.origin.x    = (newSize.width - size.width ) / 2.0
        rect.origin.y    = (newSize.height - size.height ) / 2.0
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: rect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    /**
     从指定的rect裁剪出图片
     */
    public func clipImage(with rect: CGRect) -> UIImage? {
        let clipImageRef = cgImage?.cropping(to: CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale))
        let smallBounds = CGRect(x: 0, y: 0, width: CGFloat(clipImageRef!.width) / scale, height: CGFloat(clipImageRef!.height) / scale)
        UIGraphicsBeginImageContextWithOptions(smallBounds.size, _: true, _: scale)
        let context = UIGraphicsGetCurrentContext()
        // clipImage是将要绘制的UIImage图片(防止图片上下颠倒)
        context!.translateBy(x: 0, y: smallBounds.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        context?.draw(clipImageRef!, in: CGRect(x: 0, y: 0, width: smallBounds.size.width, height: smallBounds.size.height))
        let clipImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return clipImage
    }
    
    //创建颜色Image
    public class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    /**
     *  重设图片大小
     */
    public func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    public func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width:self.size.width * scaleSize,height:self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
    
    ///获取image URL
    public func getImageUrl() -> URL? {
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask, true)[0] as String
        let filePath = "\(rootPath)/pickedimage.jpg"
        
        let imageData = self.jpegData(compressionQuality: 0.5)
        
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
        
        if (fileManager.fileExists(atPath: filePath)){
            //取得NSURL
            let imageURL = URL(fileURLWithPath: filePath)
            return imageURL
        }else{
            return nil
        }
        
    }

}

