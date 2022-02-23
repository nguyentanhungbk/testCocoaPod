//
//  FileManager+Extension.swift
//  CommonExtension
//
//  Created by Hung Nguyen on 21/02/2022.
//

import Foundation

extension FileManager {
    /// return path to document directory
    func getDocumentsDirectory() -> URL {
        return self.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    /// return path to Cache directory
    func getCacheDirectory() -> URL {
        return self.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

    func getTempDirectoryPath() -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    }

    func findFileAt(url: URL, fileExtension: String) -> [URL] {
        var updatedURL = url
        if !url.isDirectory {
            updatedURL = url.deletingLastPathComponent()
        }
        var arrFiles: [URL] = []
        do {
            // --- Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: updatedURL, includingPropertiesForKeys: nil)

            // if you want to filter the directory contents you can do like this:
            arrFiles = directoryContents.filter { $0.pathExtension == fileExtension }
            print("\(fileExtension) urls:", arrFiles)
            // let mp3FileNames = files.map{ $0.deletingPathExtension().lastPathComponent }
            // print("mp3 list:", mp3FileNames)
        } catch {
            print(error)
        }
        return arrFiles
    }

    func urls(for directory: FileManager.SearchPathDirectory, skipsHiddenFiles: Bool = true ) -> [URL]? {
        let documentsURL = urls(for: directory, in: .userDomainMask)[0]
        return contentsOfDirectory(from: documentsURL)
    }

    func contentsOfDirectory(from documentsURL: URL, skipsHiddenFiles: Bool = true ) -> [URL]? {
        let fileURLs =
            try? contentsOfDirectory(at: documentsURL,
                                     includingPropertiesForKeys: nil,
                                     options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
        return fileURLs
    }
}
