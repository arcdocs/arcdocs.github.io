#!/bin/bash

arccom module -q libraries | while read line; do echo ARC4,$line; done > arc4-libs.txt

arccom -h arc3.leeds.ac.uk module -q libraries | while read line; do echo ARC3,$line; done > arc3-libs.txt

tail -n +3 -q arc3-libs.txt arc4-libs.txt > arcs-libs.txt
