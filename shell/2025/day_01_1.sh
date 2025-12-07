#!/bin/bash

sed -E 's/(L|R)/\1\t/' <&0 \
    | awk '\
    BEGIN { dial = 50 }
    /L/   { dial -= $2 }
    /R/   { dial += $2 }
          { dial %= 100; result += dial == 0 }
    END   { print result }
    '
