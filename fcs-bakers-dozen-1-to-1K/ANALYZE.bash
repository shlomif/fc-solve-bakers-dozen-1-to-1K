#!/bin/bash

a()
{
    fn="$1"
    shift

    echo "FN == $fn"
    cat "$fn" | grep -hP '^(This game is solveable.|Iterations count|I could not)'  | sort | uniq -c
    cat "$fn" | ruby -0777 -lne 'm = $_.scan(/T=(\d+\.\d+)/); puts "Wallclock time == " + (m[-1].to_s.to_f - m[0].to_s.to_f).to_s'
}

b()
{
    cat "$1" | grep -hP '^(This game is solveable.|Iterations count|I could not)'  | ruby -lpe '$_="S" if /This game is solv/; $_="U" if /I could not/; $_="I" if /Iterations count/' ;
}

table()
{
    eval "paste <(seq 1 1000) $(for I in *-dump.txt old/*-dump.txt ; do echo -n "<(b $I) " ; done)"
}

list="37 46 74 78 79 93 100 134 154 185 188 192 206 210 216 219 238 247 248 290 297 300 306 319 333 336 342 381 417 448 454 462 464 476 477 480 506 520 537 553 554 558 578 607 650 664 677 715 745 763 764 766 804 817 822 835 837 844 846 860 862 866 871 878 908 922 926 930 944 949 950 952 969"

go_over_unsolved_indexes()
{
    (
    for idx in $list ; do
        echo "IDX=$idx" ;
        make_pysol_freecell_board.py "$idx" bakers_dozen |
        /home/shlomif/progs/freecell/git/fc-solve/fc-solve/source/scripts/summarize-fc-solve -l mo -g bakers_dozen -sp r:tf -sam -p -t -sel -mi 15000000 ;
    done
    )
}
