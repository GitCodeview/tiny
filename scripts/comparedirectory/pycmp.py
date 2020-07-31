# -*- coding: utf-8 -*-
"""
Python script for comparing the contents of two directories.

@author: Roger Woodman
"""

import os
import shutil

class DirectoryComparison():
    """Compare the contents of two directories"""

    def __init__(self, path1, path2, pathsIgnore, pathExtra):
        """Initialise variables
        
        :param path1: First path to compare
        :param path2: Second path to compare
        """
        # The folders containing files
        self.path1 = path1
        self.path2 = path2
        self.pathsIgnore = pathsIgnore
        self.pathExtra = pathExtra
        print(path1, path2, pathsIgnore, pathExtra)

    def printDirecotryDifferences(self):
        """Print all the file differences for the two paths"""

        filesAndSizes1 = self.getAllFilesAndSizes(self.path1)
        filesAndSizes2 = self.getAllFilesAndSizes(self.path2)
        
    
        # # Display file and size for path 1
        # print("-----------------------------")
        # print("Number of files: %s" % str(len(filesAndSizes1)))
        # print("-----------------------------")
        # for pair in filesAndSizes1:
        #     print(pair)
            
        # # Display file and size for path 2
        # print("-----------------------------")
        # print("Number of files: %s" % str(len(filesAndSizes2)))
        # print("-----------------------------")
        # for pair in filesAndSizes2:
        #     print(pair)    
    
        # Display the differences for path 1
        difference = list(set(filesAndSizes1) - set(filesAndSizes2))
        difference.sort()
        File=open(r'.\results.out','w',encoding='utf-8')
        headText='==========================================================\n'
        headText=headText+"Files in "+self.path1+", not in other folder: " + str(len(difference))+'\n'
        headText=headText+'-----------------------------------------------\n'
        print(headText)
        File.write(headText)
        for pair in difference:
            print(pair)
            (dirname, filename) = os.path.split(self.pathExtra+pair)
            if not os.path.exists(dirname):
                os.makedirs(dirname, 0o754 )
            shutil.copyfile(self.path1+pair, self.pathExtra+pair)
            File.write(pair+'\n')        
        
        # Display the differences for path 2
        difference = list(set(filesAndSizes2) - set(filesAndSizes1))
        difference.sort()
        headText='\n\n==========================================================\n'
        headText=headText +"Files in "+ self.path2 + ", not in other folder: " + str(len(difference))+'\n'
        headText=headText+'-----------------------------------------------\n'
        print(headText)
        File.write(headText)
        for pair in difference:
            print(pair)
            (dirname, filename) = os.path.split(self.pathExtra+pair)
            if not os.path.exists(dirname):
                os.makedirs(dirname, 0o754 )
            shutil.copyfile(self.path2+pair, self.pathExtra+pair)
            File.write(pair+'\n')    
        File.close     

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
            needIgnore = False
            for pathIgnore in self.pathsIgnore:
                if ( relativePath[:len(pathIgnore)] == pathIgnore):
                    # print('ignore path: ', path[lenRootPath:])
                    needIgnore = True
                    break
            if needIgnore:
                continue
            for name in files:
                if name.endswith(".pyc") or name.endswith(".class"):
                    continue
                
                location = os.path.join(path, name)
        
                # # Get size and add to list of tuples.
                # size = os.path.getsize(location)
                location = location[lenRootPath:]
                pairs.append(location)
            
        # Sort list of tuples by the first element, size.
        pairs.sort(key=lambda s: s[0])
        return pairs
    
if __name__ == '__main__':
    # Directory comparison test
    # directoryIgnore = [r'\out']
    # directoryComparison = DirectoryComparison(r"E:\github\tinyscripts\python3\comparedirectory\a", r"E:\github\tinyscripts\python3\comparedirectory\b", directoryIgnore)
    directoryIgnore = [r'\out']
    directoryExtra = r'E:\gitlab\chromium-stl\src-extra'
    directoryComparison = DirectoryComparison(r"E:\chromium-desktop\chromium-stl\src", r"E:\gitlab\chromium-stl\src", directoryIgnore, directoryExtra)
    # directoryIgnore = []
    # directoryComparison = DirectoryComparison(r"E:\depot_tools", r"D:\workspace\depot_tools", directoryIgnore)
    directoryComparison.printDirecotryDifferences()
    