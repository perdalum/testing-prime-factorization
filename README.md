# Testing Prime Factorization

A fun little benchmark project for comparing the speed of integer factorization across some tools that I know.

- [Wolfram Language](https://wolfram.com) (WolframScript/Mathematica)
- [PARI/GP](https://pari.math.u-bordeaux.fr) - Computer algebra system
- [bigmathfast](https://github.com/thomasegense/bigmathfast) - Java library for large numbers

`bigmathfast` is a Java library that implements factorization of large integers. For numbers less than 22 digits, the PollardRho algorithm is used. For numbers larger than 22 digits, the algorithm will use ECM/Siqs. This Java library is implemented by Thomas Egense and can be found at GitHub: [bigmathfast](https://github.com/thomasegense/bigmathfast). 

## Prerequisites

To run all benchmarks, the following must be installed:

- [WolframScript](https://www.wolfram.com/wolframscript/) - Part of Wolfram Mathematica or Wolfram Engine
- [PARI/GP](https://pari.math.u-bordeaux.fr) - Computer algebra system
- Java - To run the bigmathfast JAR file
- `bigmathfast` can be downloaded from Thomas' GitHub project.
- Python 3 - For the bigmathfast wrapper script

You also need some large integers to test with. I've provided the following which are the same integers as used in the `bigmathfast` tests.

    30, 147275865199119510385557165977
    40, 1468859383233401953850079471177142403357
    50, 8924060181263144762913076834769824195165519271249
    60, 57006543036882955477733064155963100765859988504898777062311
    70, 2008366610044614145105509426936481148630631765118331491742083502567441
    80, 93035149443954345347665179408833277091909532522394543659489519897196854705698057
    90, 235619162309580984868967318620943039846576548536713751373304739395055583551615448989006587

All these integers are products of two large prime numbers and therefore worst-case scenarios for factorization.

## Project Structure

- `factorize-all.sh` - Main script that runs all three benchmarks
- `factorize.wls` - Wolfram Language implementation
- `factorize.gp` - PARI/GP implementation
- `factorize-bigmathfast.py` - Python wrapper for Java bigmathfast
- `bigmathfast-1.0-jar-with-dependencies.jar` - Java library
- `large-ints-*.txt` - Test data with large integers

## Benchmark Results

### MacBook Air M2 with 24GB RAM

    >: wolframscript -version
    WolframScript 1.13.0 for Mac OS X ARM (64-bit)

    >: wolframscript -f factorize.wls large-ints-5.txt;echo "80   NA\n90   NA" > wls.out
    cat wls.out
    30   19.692 
    40   80.359 
    50   1583.59
    60   17965.5
    70   377270.
    80    NA
    90    NA
    

     >: gp --version
                      GP/PARI CALCULATOR Version 2.17.2 (released)
             arm64 running darwin (aarch64/GMP-6.3.0 kernel) 64-bit version
         compiled: Feb 28 2025, Apple clang version 17.0.0 (clang-1700.3.19.1)
                               threading engine: pthread
                    (readline v8.3 disabled, extended help enabled)
 
    $ LARGE_INTS=large-ints-7.txt gp -q factorize.gp 2>/dev/null > gp.out
    cat gp.out
    30	4
    40	18
    50	149
    60	1628
    70	11339
    80	270966
    90	3604437

    #bigmathfast-1.0-jar-with-dependencies.jar

    ./factorize-bigmathfast.py large-ints-7.txt > bmf.out
    cat bmf.out
    30	64
    40	181
    50	965
    60	3654
    70	18411
    80	283088
    90	3503897
 
With the output in three data files, it can be compared against e.g., PARI/GP as the baseline.

     >: paste gp.out bmf.out wls.out|cut -f1,2,4,6| awk 'BEGIN {OFS="|"} NR<6 {print $1,$2/$2,$3/$2,$4/$2} NR>5 {print $1, $2/$2,$3/$2,"NA"}'|sed 's/^/|/;s/$/|/'|pbcopy


| no. of digits | PARI/GP | bigmathfast |  Wolfram |
|--------------:|--------:|------------:|---------:|
|            30 |       1 |          16 |    4.923 |
|            40 |       1 |     10.0556 |  4.46439 |
|            50 |       1 |     6.47651 |  10.6281 |
|            60 |       1 |     2.24447 |  11.0353 |
|            70 |       1 |     1.62369 |  33.2719 |
|            80 |       1 |     1.04474 |       NA |
|            90 |       1 |    0.972107 |       NA |


PARI/GP is the baseline, and the numbers indicate how faster PARI/GP is. E.g., for a 30-digit integer, PARI/GP is 16 times faster than `bigmathfast` and 4.923 times faster than Wolfram. The relative slowness of `bigmathfast` is probably due to start-up time for the Java VM.

One could also begin to ponder on caches and other shenanigans used by the different engines. I do know that for huge integers, I would choose PARI/GP or `bigmathfast`. For really huge integers, it seems like `bigmathfast` is faster than PARI/GP – quite fitting for its name :-)

## Author

Per Møldrup-Dalum

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.