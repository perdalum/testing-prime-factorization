#!/bin/zsh

INPUT=$1

echo "## Wolfram ##"
wolframscript -version
wolframscript -f factorize.wls $INPUT
echo "###########################"

echo "## PARI/GP ##"
gp --version
LARGE_INTS=$INPUT gp -q factorize.gp
echo "###########################"

echo "## bigmathfast ##"
ls bigmathfast-1.0-jar-with-dependencies.jar
./factorize-bigmathfast.py $INPUT
echo "###########################"