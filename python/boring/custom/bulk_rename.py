'''                                                                             
Fix up file index with bulk rename                                              
'''
import shutil, os, re
pattern = re.compile("^[2-7]")
for initFile in sorted(os.listdir('.')):
    initFile = os.path.basename(os.path.realpath(initFile))
    it = pattern.search(initFile)
    if it == None:
        continue
    h,t = initFile.split('-')
    h = int(h)
    #t = t.replace(':', '/')                                                    
    if h < 27:
        continue
    h2 = h-1
    #print(initFile)                                                            
    #print(f"{h} {h2}")                                                         
    initFile = f"{h}-{t}"
    newFile = f"{h2}-{t}"
    #print(newFile)                                                             
    print(f"{initFile} -> {newFile}")
    shutil.move(initFile, newFile)
