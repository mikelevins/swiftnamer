swiftnamer
v 0.2

USAGE:
  swiftnamer COUNT PATHNAME

Returns a list of COUNT names, generated from the examples in the file PATHNAME.

If executed with fewer than two arguments, swiftnamer prints usage instructions.

COUNT must be a positive integer.

PATHNAME must be the path of a text file containing one sample name per line.

The "data" subdirectory contains several files of sample names in ".names" files. Give one of these to swiftnamer as its second argument to see names generated in the style of those samples.

You can create your own ".names" file simply by adding a text file with a single sample name on each line.
