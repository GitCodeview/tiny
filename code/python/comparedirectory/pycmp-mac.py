# -*- coding: utf-8 -*-
"""
Python script for comparing the contents of two directories.
"""

import os
import shutil

class DirectoryComparison():
    """Compare the contents of two directories"""

    def __init__(self, path1, path2, pathsIgnore, filesIgnore, pathExtra):
        """Initialise variables
        
        :param path1: First path to compare
        :param path2: Second path to compare
        """
        # The folders containing files
        self.path1 = path1
        self.path2 = path2
        self.pathsIgnore = pathsIgnore
        self.filesIgnore = filesIgnore
        self.pathExtra = pathExtra
        print('Path1: ', path1, 
              '\nPath2: ', path2, 
              '\npathsIgnore: ', pathsIgnore, 
              '\nfilesIgnore: ', filesIgnore, 
              '\npathExtra: ', pathExtra)

    def printDirecotryDifferences(self):
        """Print all the file differences for the two paths"""

        filesAndSizes1 = self.getAllFilesAndSizes(self.path1)
        filesAndSizes2 = self.getAllFilesAndSizes(self.path2)
    
        # Display the differences for path 1
        difference = list(set(filesAndSizes1) - set(filesAndSizes2))
        difference.sort()
        File=open(self.pathExtra+r'_results.out','w',encoding='utf-8')
        headText='==========================================================\n'
        headText=headText+"Files in "+self.path1+", not in other folder: " + str(len(difference))+'\n'
        headText=headText+'-----------------------------------------------\n'
        print(headText)
        File.write(headText)
        for pair in difference:
            print(pair)
            (dirname, filename) = os.path.split(self.pathExtra+pair)
            if not os.path.exists(dirname):
                os.makedirs(dirname)
            if os.path.exists(self.path1+pair):
                cpcmd = "cp -f " + self.path1+pair + " " + self.pathExtra+pair
                os.system(cpcmd)
                # print(self.path1+pair, self.pathExtra+pair)
                # shutil.copy(self.path1+pair, self.pathExtra+pair)
                File.write(pair+'\n')
            else:
                File.write(pair+'[NotExisted]\n') 
        
        # Display the differences for path 2
        # difference = list(set(filesAndSizes2) - set(filesAndSizes1))
        # difference.sort()
        # headText='\n\n==========================================================\n'
        # headText=headText +"Files in "+ self.path2 + ", not in other folder: " + str(len(difference))+'\n'
        # headText=headText+'-----------------------------------------------\n'
        # print(headText)
        # File.write(headText)
        # for pair in difference:
        #     print(pair)
        #     (dirname, filename) = os.path.split(self.pathExtra+pair)
        #     if not os.path.exists(dirname):
        #         os.makedirs(dirname, 0o754 )
        #     # cpcmd = "cp -f " + self.path2+pair + " " + self.pathExtra+pair
        #     # os.system(cpcmd)
        #     print(self.path2+pair, self.pathExtra+pair)
        #     shutil.copy(self.path2+pair, self.pathExtra+pair)
        #     File.write(pair+'\n')
        # File.close()

    def getAllFilesAndSizes(self, path):
        """Gets all the file names and sizes in a path
        
        :param path: Search path
        """        
        pairs = []
        lenRootPath =  len(path)
        # Loop and add files to list.
        for path, subdirs, files in os.walk(path):
            # print(path, subdirs, files)
            relativePath = path[lenRootPath:]
            needPathIgnore = False
            for pathIgnore in self.pathsIgnore:
                if ( relativePath[:len(pathIgnore)] == pathIgnore):
                    print('ignore path: ', path[lenRootPath:])
                    needPathIgnore = True
                    break
            if needPathIgnore:
                continue
            for name in files:
                location = os.path.join(path, name)
                # # Get size and add to list of tuples.
                # size = os.path.getsize(location)
                location = location[lenRootPath:]
                needFileIgnore = False
                for filesEnd in self.filesIgnore:
                    if name.endswith(filesEnd):
                        print('ignore file: ', location)
                        needFileIgnore = True
                        break
                if needFileIgnore:
                    continue
                pairs.append(location)
            
        # Sort list of tuples by the first element, size.
        pairs.sort(key=lambda s: s[0])
        return pairs
    
if __name__ == '__main__':
    # Directory comparison test
    # pathsIgnore = [r'\out']
    # directoryComparison = DirectoryComparison(r"E:\github\tinyscripts\python3\comparedirectory\a", r"E:\github\tinyscripts\python3\comparedirectory\b", pathsIgnore)
    ## windows
    # pathsIgnore = [r'\out']
    # directoryExtra = r'E:\gitlab\chromium-stl\src-extra'
    # directoryComparison = DirectoryComparison(r"E:\chromium-desktop\chromium-stl\src", r"E:\gitlab\chromium-stl\src", pathsIgnore, directoryExtra)
    ## mac
    pathsIgnore = [r'/out',r'/.git']
    filesIgnore = [r'.pyc',r'.class',r'.DS_Store']
    directoryExtra = r'/Users/stl/workspace/browser/src-extra/src-test'
    # directoryComparison = DirectoryComparison(r"/Users/stl/workspace/browser/chromium_78.0.3904.97/src", r"/Users/stl/workspace/browser/chromium-78.0.3904.97/src", pathsIgnore, directoryExtra)
    # directoryComparison = DirectoryComparison(r"/Users/stl/workspace/browser/chromium_78.0.3904.97/src", 
    #                                           r"/Users/stl/workspace/browser/src-refs_tags_78.0.3904.97", 
    #                                           pathsIgnore, 
    #                                           filesIgnore, 
    #                                           directoryExtra)
    directoryComparison = DirectoryComparison(r"/Users/stl/workspace/browser/chromium_78.0.3904.97/src", 
                                              r"/Users/stl/workspace/browser/website-custom/src", 
                                              pathsIgnore, 
                                              filesIgnore, 
                                              directoryExtra)
    
    # pathsIgnore = []
    # directoryComparison = DirectoryComparison(r"E:\depot_tools", r"D:\workspace\depot_tools", pathsIgnore)
    directoryComparison.printDirecotryDifferences()
    