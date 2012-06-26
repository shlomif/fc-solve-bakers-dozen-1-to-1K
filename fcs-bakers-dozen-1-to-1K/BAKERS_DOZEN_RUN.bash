#!/bin/bash

start_idx=1
finish_idx=1000

export FREECELL_SOLVER_QUIET=1
mytime()
{
    theme="$1"
    shift
    fn="$1"
    shift

    temp_fn="total_dump.txt"

    date +"START_T=%s.%N" > "$temp_fn"
    MS=1 VARIANT="bakers_dozen" THEME="$theme" time bash ../scripts/run-variant-sequence.sh "$start_idx" "$finish_idx"
    mv -f "$temp_fn" "$fn"
}

run_all()
{
    mytime "-to 0123456789" "0123456789-dump.txt"
    mytime "-to 0123456789 -sp r:tf" "0123456789-sp-r-tf-dump.txt"
    mytime "-to 01ABCDE" "01ABCDE-dump.txt"
    mytime "-to 01ABCDE -sp r:tf" "01ABCDE-sp-r-tf-dump.txt"
    mytime "-to 0123456789 -sp r:tf --method a-star" "befs-0123456789-dump.txt"
    mytime "-to 01ABCDE -sp r:tf --method a-star" "befs-01ABCDE-dump.txt"
}

run_all

(
    cd /home/shlomif/progs/freecell/git/benchmark-before/fc-solve/source/build/
    run_all
)
