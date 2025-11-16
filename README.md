# Testing Prime Factorization

A fun little benchmark project for comparing the speed of prime factorization across different tools.

## Purpose

This project is a fun project to test and compare the performance of prime factorization for large integers using:

- **Wolfram Language** (WolframScript)
- **PARI/GP** - Computer algebra system
- **bigmathfast** - Java library for large numbers

bigmathfast is a Java library that implements factorization of large integers. For numbers less than 22 digits the PollardRho algorithm is used. For numbers larger than 22 digits, the algorithm will use ECM/Siqs. This Java library is implemented by Thomas Egense and can be found at GitHub: [bigmathfast](https://github.com/thomasegense/bigmathfast). 

## Prerequisites

To run all benchmarks, the following must be installed:

- [WolframScript](https://www.wolfram.com/wolframscript/">WolframScript) - Part of Wolfram Mathematica or Wolfram Engine
- [PARI/GP](https://pari.math.u-bordeaux.fr) - Computer algebra system
- Java - To run the bigmathfast JAR file
- bigmathfast as described above
- Python 3 - For the bigmathfast wrapper script

You also need some large integers to test with. I've provided the following which are the same integers as used in the bigmathfast tests.

    30, 147275865199119510385557165977
    40, 1468859383233401953850079471177142403357
    50, 8924060181263144762913076834769824195165519271249
    60, 57006543036882955477733064155963100765859988504898777062311
    70, 2008366610044614145105509426936481148630631765118331491742083502567441
    80, 93035149443954345347665179408833277091909532522394543659489519897196854705698057
    90, 235619162309580984868967318620943039846576548536713751373304739395055583551615448989006587


## Project Structure

- `factorize-all.sh` - Main script that runs all three benchmarks
- `factorize.wls` - Wolfram Language implementation
- `factorize.gp` - PARI/GP implementation
- `factorize-bigmathfast.py` - Python wrapper for Java bigmathfast
- `bigmathfast-1.0-jar-with-dependencies.jar` - Java library
- `large-ints-*.txt` - Test data with large integers
- `run.sh` - Example of single Java execution

## Usage

Example

    factorize-all.sh large-ints-3.txt 

will outout metadata on the engines and for each engine, print a line for each line in the input file with number of digits and time taken to factorize measured in milliseconds.

## Benchmark Results

### MacBook Air M2 with 24GM RAM

	 >: ./factorize-all.sh large-ints-3.txt
	## Wolfram ##
	WolframScript 1.13.0 for Mac OS X ARM (64-bit)
	30   19.435 
	40   76.913 
	50   1576.35
	###########################
	## PARI/GP ##
	          GP/PARI CALCULATOR Version 2.17.2 (released)
	 arm64 running darwin (aarch64/GMP-6.3.0 kernel) 64-bit version
	compiled: Feb 28 2025, Apple clang version 17.0.0 (clang-1700.3.19.1)
	                    threading engine: pthread
	         (readline v8.3 disabled, extended help enabled)
	30      2
	40      16
	50      150
	###########################
	## bigmathfast ##
	bigmathfast-1.0-jar-with-dependencies.jar
	30      63
	40      202
	50      860
	###########################