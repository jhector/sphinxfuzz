Hackish AFL fuzzing environment for pocketsphinx.

In wrap.c, the path to the directory needs to be adjusted.
In the Makefile, the path to afl-clang-fast must be adjusted.

It is important that this is compiled using afl-clang-fast, because the position of the fork server has been manually set to improve performance.
