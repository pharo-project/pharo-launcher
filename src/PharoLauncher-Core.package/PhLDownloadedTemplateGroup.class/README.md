I represent a group of templates already downloaded from the network. I maintain a set of zip files in my baseDirectory and a cache.json which contains meta-data about these files.

IMPLEMENTATION

I don't cache anything as variables in the image. For each action, I read the cache.json and update it.