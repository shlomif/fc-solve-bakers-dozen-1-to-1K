#!/bin/bash
( for idx in 238 ; do
    echo "IDX=$idx" ;
    make_pysol_freecell_board.py -t "$idx" bakers_dozen |
    /home/shlomif/progs/freecell/git/fc-solve/fc-solve/source/scripts/summarize-fc-solve \
        -g bakers_dozen -l mo \
        -sp r:tf -sam -p -t -sel -mi 100000000 ;
done ) | tee -a bakers_dozen_unsolved_indexes__4.txt
