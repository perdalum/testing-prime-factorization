# Testing Prime Factorization

A fun little benchmark project for comparing the speed of prime factorization across different tools.

## Purpose

This project is a fun project to test and compare the performance of prime factorization for large integers using:

- [Wolfram Language](https://wolfram.com) (WolframScript)
- [PARI/GP](https://pari.math.u-bordeaux.fr) - Computer algebra system
- [bigmathfast](https://github.com/thomasegense/bigmathfast) - Java library for large numbers

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

will output metadata on the engines and for each engine, print a line for each line in the input file with the number of digits and time taken to factorize measured in milliseconds.

## Benchmark Results

### MacBook Air M2 with 24GB RAM

    >: ./factorize-all.sh large-ints-5.txt
    ###########################
    ## Wolfram ##
    WolframScript 1.13.0 for Mac OS X ARM (64-bit)
    30   19.692 
    40   80.359 
    50   1583.59
    60   17965.5
    70   377270.
    
>: ./factorize-all.sh large-ints-3.txt
    ###########################
    ## PARI/GP ##
    30	4
    40	18
    50	149
    60	1628
    70	11339
    80	270966
    90	3604437
    
    ###########################
    ## bigmathfast ##
    bigmathfast-1.0-jar-with-dependencies.jar
    30	64
    40	181
    50	965
    60	3654
    70	18411
    80	283088
    90	3503897
    


## Author

Per Møldrup-Dalum

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.