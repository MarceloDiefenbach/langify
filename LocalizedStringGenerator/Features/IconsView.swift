////
////  IconsView.swift
////  LocalizedStringGenerator
////
////  Created by Marcelo Diefenbach on 29/04/23.
////
//
//import Foundation
//import SwiftUI
//
//struct IconsView: View {
//    
//    @EnvironmentObject var viewModel: CoordinatorViewModel
//    @State var image: NSImage?
//    let sizes: [CGSize] = [
//        CGSize(width: 16, height: 16),
//        CGSize(width: 32, height: 32),
//        CGSize(width: 64, height: 64),
//        CGSize(width: 128, height: 128),
//        CGSize(width: 256, height: 256),
//        CGSize(width: 512, height: 512),
//        CGSize(width: 1024, height: 1024),
//    ]
//    
//    var body: some View {
//        ZStack {
//            VStack {
//                if image != nil {
//                    Image(nsImage: image!)
//                                .resizable()
//                                .frame(width: 300, height: 300)
//                }
//                HStack {
//                    LGButton(title: "Choose icon", action: {
//                        image = chooseImageFromDocuments()
//                    }, isClear: false)
//                    LGButton(title: "Generate icons", action: {
//                        saveResizedImage(image!, sizes: sizes)
//                    }, isClear: true)
//                }
//            }
//        }
//        .frame(width: 800, height: 600)
//    }
//    
//    func chooseImageFromDocuments() -> NSImage? {
//        let openPanel = NSOpenPanel()
//        openPanel.canChooseFiles = true
//        openPanel.canChooseDirectories = false
//        openPanel.allowsMultipleSelection = false
//        openPanel.allowedFileTypes = ["jpg", "jpeg", "png"]
//        
//        guard openPanel.runModal() == .OK, let imageURL = openPanel.url else {
//            return nil
//        }
//        
//        guard let image = NSImage(contentsOf: imageURL) else {
//            return nil
//        }
//        
//        return image
//    }
//
//    func saveResizedImage(_ image: NSImage, sizes: [CGSize]) {
//        
//        let downloadsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
//        let folderURL = downloadsDirectory.appendingPathComponent("AppIcon.appiconset", isDirectory: true)
//        
//        for size in sizes {
//            guard let data = image.tiffRepresentation else {
//                return
//            }
//
//            guard let bitmap = NSBitmapImageRep(data: data) else {
//                return
//            }
//
//            let size2 = CGSize(width: size.width/2, height: size.height/2)
//            print(size2)
//            let imageResized = NSImage(size: size2)
//            imageResized.lockFocus()
//            bitmap.draw(in: NSRect(origin: .zero, size: size2))
//            imageResized.unlockFocus()
//
//            var fileExtension = "png"
//
//            let fileURL = folderURL.appendingPathComponent("\(Int(size.width)).\(fileExtension)")
//
//            guard let fileData = imageResized.tiffRepresentation, let representation = NSBitmapImageRep(data: fileData) else {
//                return
//            }
//
//            let properties = [NSBitmapImageRep.PropertyKey.compressionFactor: NSNumber(value: 1.0)]
//            let imageData = representation.representation(using: .png, properties: properties)
//
//            do {
//                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
//                try imageData?.write(to: fileURL)
//            } catch {
//                print("Error saving image: \(error)")
//            }
//        }
//        generateIconJSON(for: sizes, downloadsFolderURL: folderURL)
//    }
//    
//    func generateIconJSON(for sizes: [CGSize], downloadsFolderURL: URL) -> String? {
//        var images: [[String: Any]] = []
//        for (index, size) in sizes.enumerated() {
//            if index != sizes.count - 1 {
//                let expectedSize = max(size.width, size.height)
//                let imageName = "\(Int(expectedSize)).png"
//                let imageFolder = "MyResizedImages/"
//                let image = [
//                    "size": "\(Int(size.width))x\(Int(size.height))",
//                    "expected-size": "\(Int(expectedSize))",
//                    "filename": "\(Int(size.width)).png",
//                    "folder": "Assets.xcassets/AppIcon.appiconset/",
//                    "idiom": "mac",
//                    "scale": "1x"
//                ]
//                let image2 = [
//                    "size": "\(Int(size.width))x\(Int(size.height))",
//                    "expected-size": "\(Int(expectedSize)*2)",
//                    "filename": "\(Int(size.width)*2).png",
//                    "folder": "Assets.xcassets/AppIcon.appiconset/",
//                    "idiom": "mac",
//                    "scale": "2x"
//                ]
//                images.append(image)
//                images.append(image2)
//            }
//        }
//        let jsonDictionary: [String: Any] = ["images": images]
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: [.prettyPrinted])
//            let folderURL = downloadsFolderURL.appendingPathComponent("AppIcon.appiconset", isDirectory: true)
//            let fileURL = folderURL.appendingPathComponent("Contents.json")
//            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
//            try jsonData.write(to: fileURL)
//            return fileURL.path
//        } catch {
//            print("Error generating JSON: \(error)")
//            return nil
//        }
//    }
//
//
//
//}
//
//struct IconsView_Previews: PreviewProvider {
//    static var previews: some View {
//        IconsView()
//    }
//}
