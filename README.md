# findlatest

Application that will list all files in a directory (and subdirectories)
with a given extension. However, if there are any files with identical
names (but different paths of course) only the file with the latest
modification time will be listed.

The output filenames are null-separated and suitable for piping
into `xargs -0`.  For example:

    findlatest .stack hs | xargs -0 -n 1 echo


# TODO

This tool is very rudimentary and solves one specific problem.
Opportunities to generalize include:

- Allow multiple directories
- Allow multiple extensions
- Allow other seach terms than extensions
- Proper option handling with optparse-applicative
- Option for output (null separated, quoted, …)
