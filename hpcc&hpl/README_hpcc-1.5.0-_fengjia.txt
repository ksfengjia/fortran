    
          DARPA/DOE HPC Challenge Benchmark version 1.5.0beta
          ***************************************************
                           Piotr Luszczek (1)
                           ==================
                            October 12, 2012
                            ================
  


1  Introduction
*=*=*=*=*=*=*=*

	This is a suite of benchmarks that measure performance of processor,memory subsytem, and the interconnect. 
	For details refer to the HPC Challenge web site (http://icl.cs.utk.edu/hpcc/.)
	In essence, HPC Challenge consists of a number of tests each of which measures performance of a different aspect of the system.
	If you are familiar with the High Performance Linpack (HPL) benchmark code (see the HPL web site: http://www.netlib.org/benchmark/hpl/) then you can reuse the build script file (input for make(1) command) and the input file that you already have for HPL. 
	The HPC Challenge benchmark includes HPL and uses its build script and input files with only slight modifications.
	The most important change must be done to the line that sets the TOPdir variable. 
	For HPC Challenge, the variable's value should always be ../../.. regardless of what it was in the HPL build script file.


2  Compiling
*=*=*=*=*=*=

	The first step is to create a build script file that reflects characteristics of your machine. 
	第一步是创建一个反映您的计算机特性的build脚本文件。
	This file is reused by all the components of the HPC Challenge suite. 
	此文件被HPCC套件的所有组件重用。
	The build script file should be created in the hpl directory. 
	build脚本在hpl路径下创建。
	This directory contains instructions (the files README and INSTALL) on how to create the build script file for your system.
	此目录包含有关如何为系统创建生成脚本的说明 ( 文件README 和INSTALL)。
	The hpl/setup directory contains many examples of build script files. 
	hpl/setup下包含许多生成脚本的例子。
	A recommended approach is to copy one of them to the hpl directory and if it doesn't work then change it.
	一个建议的方法是将其中一个文件复制到 hpl 目录中, 如果它不工作, 则更改它。
	The build script file has a name that starts with Make. prefix and usally ends with a suffix that identifies the target system.
	
	For example, if the suffix chosen for the system is Unix, the file should be named Make.Unix.
	
	To build the benchmark executable (for the system named Unix) type: make arch=Unix. 
	This command should be run in the top directory (not in the hpl directory).
	It will look in the hpl directory for the build script file and use it to build the benchmark executable.
	
	The runtime behavior of the HPC Challenge source code may be configured at compiled time by defining a few C preprocessor symbols.
	HPCC源代码的运行状态在编译时定义C预处理器符号进行配置。
	They can be defined by adding appropriate options to CCNOOPT and CCFLAGS make variables. 
	通过 CCNOOPT 和 CCFLAGS 变量添加适当的选项来定义它们。
	The former controls options for source code files that need to be compiled without aggressive optimizations to ensure accurate generation of system-specific parameters. 
	
	The latter applies to the rest of the files that need good compiler optimization for best performance.
	
	To define a symbol S, the majority of compilers requires option -DS to be used.
	Currently, the following options are available in the HPC Challenge source code: 
	
	- HPCC_FFT_235: if this symbol is defined the FFTE code (an FFT
	implementation) will use vector sizes and processor counts that are
	not limited to powers of 2. Instead, the vector sizes and processor
	counts to be used will be a product of powers of 2, 3, and 5.
	
	- HPCC_FFTW_ESTIMATE: if this symbol is defined it will affect the
	way external FFTW library is called (it does not have any effect if
	the FFTW library is not used). When defined, this symbol will call
	the FFTW planning routine with FFTW_ESTIMATE flag (instead of
	FFTW_MEASURE). This might result with worse performance results but
	shorter execution time of the benchmark. Defining this symbol may
	also positively affect the memory fragmentation caused by the FFTW's
	planning routine.
	
	- HPCC_MEMALLCTR: if this symbol is defined a custom memory allocator
	will be used to alleviate effects of memory fragmentation and allow
	for larger data sets to be used which may result in obtaining better
	performance.
	
	- HPL_USE_GETPROCESSTIMES: if this symbol is defined then
	Windows-specific GetProcessTimes() function will be used to measure
	the elapsed CPU time.
	
	- USE_MULTIPLE_RECV: if this symbol is defined then multiple
	non-blocking receives will be posted simultaneously. By default only
	one non-blocking receive is posted.
	
	- RA_SANDIA_NOPT: if this symbol is defined the HPC Challenge
	standard algorithm for Global RandomAccess will not be used. Instead,
	an alternative implementation from Sandia National Laboratory will be
	used. It routes messages in software across virtual hyper-cube
	topology formed from MPI processes.
	
	- RA_SANDIA_OPT2: if this symbol is defined the HPC Challenge
	standard algorithm for Global RandomAccess will not be used. Instead,
	instead an alternative implementation from Sandia National Laboratory
	will be used. This implementation is optimized for number of
	processors being powers of two. The optimizations are sorting of data
	before sending and unrolling the data update loop. If the number of
	process is not a power two then the code is the same as the one
	performed with the RA_SANDIA_NOPT setting.
	
	- RA_TIME_BOUND_DISABLE: if this symbol is defined then the standard
	Global RandomAccess code will be used without time limits. This is
	discouraged for most runs because the standard algorithm tends to be
	slow for large array sizes due to a large overhead for short MPI
	messages.
	
	- USING_FFTW: if this symbol is defined the standard HPC Challenge
	FFT implemenation (called FFTE) will not be used. Instead, FFTW
	library will be called. Defining the USING_FFTW symbol is not
	sufficient: appropriate flags have to be added in the make script so
	that FFTW headers files can be found at compile time and the FFTW
	libraries at link time.
  

3  Runtime Configuration
*=*=*=*=*=*=*=*=*=*=*=*=

   The HPC Challenge is driven by a short input file named hpccinf.txt
that is almost the same as the input file for HPL (customarily called
HPL.dat). Refer to the directory hpl/www/tuning.html for details about
the input file for HPL. A sample input file is included with the
HPC Challenge distribution.
  The differences between HPL's input file and HPC Challenge's input
file can be summarized as follows:
  
  
   - Lines 3 and 4 are ignored. The output is always appended to the
   file named hpccoutf.txt. 
   - There are additional lines (starting with line 33) that may (but do
   not have to) be used to customize the HPC Challenge benchmark. They
   are described below. 
  
  The additional lines in the HPC Challenge input file (compared to the
HPL input file) are:
  
  
   - Lines 33 and 34 describe additional matrix sizes to be used for
   running the PTRANS benchmark (one of the components of the
   HPC Challenge benchmark). 
   - Lines 35 and 36 describe additional blocking factors to be used for
   running the PTRANS test. 
  
  Just for completeness, here is the list of lines of the HPC
Challenge's input file and brief description of their meaning: 
  
   - Line 1: ignored 
   - Line 2: ignored 
   - Line 3: ignored 
   - Line 4: ignored 
   
   - Line 5: number of matrix sizes for HPL (and PTRANS) 
   - Line 6: matrix sizes for HPL (and PTRANS) 
   第5、6行说明求解矩阵的大小N
   
   - Line 7: number of blocking factors for HPL (and PTRANS) 
   - Line 8: blocking factors for HPL (and PTRANS)
   第7、8行说明求解矩阵分块的大小NB
   NB值的选择主要是通过实际测试得到最优值。但NB的选择上还是有一些规律可寻，如：NB不可能太大或太小，一般在256以下；
   NB×8一定是Cache line的倍数等等。我在这里给出一些我的测试经验值，供大家参考。
   平台 L2 Cache 数学库 NB ATLAS 400;MKL 384;Intel P4 Xeon L2：512KB GOTO 192;AMD Opteron L2：1MB GOTO 232  
   
   - Line 9: type of process ordering for HPL 
   	MAP process mapping (0=Row-,1=Column-major)
	第9行是HPL 1.0a的新增项，是选择处理器阵列是按列的排列方式还是按行的排列方式。
	在HPL 1.0中，其缺省方式就是按列的排列方式。
	按HPL文档中介绍，按列的排列方式适用于节点数较多、每个节点内CPU数较少的瘦系统；而按行的排列方式适用于节点数较少、每个节点内CPU数较多的胖系统。
	我只在机群系统上进行过测试，在机群系统上，按列的排列方式的性能远好于按行的排列方式。
      
   - Line 10: number of process grids for HPL (and PTRANS) 
   - Line 11: numbers of process rows of each process grid for HPL (and
   PTRANS) 
   - Line 12: numbers of process columns of each process grid for HPL
   (and PTRANS)
	第10～12行说明二维处理器网格（P×Q）。二维处理器网格（P×Q）的要遵循以下几个要求：
	􀁺 P×Q＝进程数。这是HPL的硬性规定。
	􀁺 P×Q＝系统CPU数＝进程数。一般来说一个进程对于一个CPU可以得到最佳性能。对于Intel Xeon来说，关闭超线程可以提高HPL性能。
	􀁺 P≤Q。这是一个测试经验值。一般来说，P的值尽量取得小一点，因为列向通信量（通信次数和通信数据量）要远大于横向通信。
	􀁺 P＝2n，即P最好选择2的幂,P=1,2,4,8,16,…。HPL中，L分解的列向通信采用二元交换法（Binary Exchange），
		当列向处理器个数P为2的幂时，性能最优。另外，U的广播中，Long法和二元交换法也在P为2的幂时性能最优。
	􀁺 当进程数为平方数时，如进程数为64，试试4×16的方式，兴许性能要不8×8好。

   - Line 13: threshold value not to be exceeded by scaled residual for HPL (and PTRANS) 
   第13行说明阈值。我读了HPL程序，这个值就是在做完线性方程组的求解以后，检测求解结果是否正确。
   若误差在这个值以内就是正确，否则错误。一般而言，若是求解错误，其误差非常大；若正确则很小。所以没有必要修改此值。
   
   - Line 14: number of panel factorization methods for HPL 
   - Line 15: panel factorization methods for HPL 
   - Line 16: number of recursive stopping criteria for HPL 
   - Line 17: recursive stopping criteria for HPL 
   - Line 18: number of recursion panel counts for HPL 
   - Line 19: recursion panel counts for HPL 
   - Line 20: number of recursive panel factorization methods for HPL 
   - Line 21: recursive panel factorization methods for HPL
	第14～21行指明L分解的方式
	在消元过程中，HPL采用每次完成NB列的消元，然后更新后面的矩阵。这NB的消元就是L的分解。每次L的分解只在一列处理器中完成。
	对每一个小矩阵作消元时，都有三种算法：L、R、C，分别代表Left、Right和Crout。在LU分解中，具体的算法很多，HPL就采用了这三种。
	对这三种算法的具体描述可参考相关LU分解的资料，也可参加HPL的源代码，我在这里不过进一步的说明。
	据我的测试经验，NDIVs选择2比较理想，NBMINs 4或8都不错。
   
   - Line 22: number of broadcast methods for HPL 
   - Line 23: broadcast methods for HPL 
   第22、23行说明L的横向广播方式，HPL中共提供六种广播方式。
   其中前四种适合于快速网络；后两种采用将数据切割后传送的方式，主要适合于速度较慢的网络。
   
   - Line 24: number of look-ahead depths for HPL 
   - Line 25: look-ahead depths for HPL 
   第24、25行说明横向通信的通信深度。
	这部分由于时间关系代码读的不是非常明白，大体的意思是这样的。
	L的分解过程是一个相对比较耗时的过程，为了提高性能，其采用先作一部分分解，然后将这一部分结果广播出去。
	“DEPTHs”值就是说明将L分几次广播。DEPTHs＝0表明将L一次性广播出去，也就是将整个L分解完成以后在一次性广播；DEPTHs＝1表示将L分两次广播；依此类推。
	L分为多次广播可以使得下一列处理器尽早得到数据，尽早开始下一步分解。但这样会带来额外的系统开销和内存开销。
	DEPTHs的值每增加1，每个进程需要多申请约（N/Q＋N/P＋NB＋1）×NB×8的内存。
	这对HPL的开销是很大的，因为增加DEPTHs以后，为了保证不使用缓冲区，不得不减小问题规模N的值，所以在N和DEPTHs需要作一个权衡。
	根据我的测试经验，在小规模系统中，DEPTHs一般选择1或2；对于大规模系统，选择2～5之间。
	
   - Line 26: swap methods for HPL 
   - Line 27: swapping threshold for HPL
	第26、27行说明U的广播算法。   
	
   - Line 28: form of L1 for HPL 
   - Line 29: form of U for HPL 
   - Line 30: value that specifies whether equilibration should be used
   by HPL 
   - Line 31: memory alignment for HPL 
   - Line 32: ignored 
   - Line 33: number of additional problem sizes for PTRANS 
   - Line 34: additional problem sizes for PTRANS 
   - Line 35: number of additional blocking factors for PTRANS 
   - Line 36: additional blocking factors for PTRANS 
  


4  Running
*=*=*=*=*=

   The exact way to run the HPC Challenge benchmark depends on the MPI
implementation and system details. An example command to run the
benchmark could like like this: mpirun -np 4 hpcc. The meaning of the
command's components is as follows: 
  
   - mpirun is the command that starts execution of an MPI code.
   Depending on the system, it might also be aprun, mpiexec, mprun, poe,
   or something appropriate for your computer.
 
   - -np 4 is the argument that specifies that 4 MPI processes should be
   started. The number of MPI processes should be large enough to
   accomodate all the process grids specified in the hpccinf.txt file.
 
   - hpcc is the name of the HPC Challenge executable to run. 
  
  After the run, a file called hpccoutf.txt is created. It contains
results of the benchmark. This file should be uploaded through the web
form at the HPC Challenge website.


5  Source Code Changes across Versions (ChangeLog)
*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=

  


5.1  Version 1.5.0 (2016-03-18)
===============================
   
  
   1. Fixed memory leak in STREAM code. 
   2. Fixed bug in STREAM that resulted in minimum results reported as
   0. 
   3. Removed some of the compilation warnings. 
  


5.2  Version 1.5.0beta (2015-07-23)
===================================
   
  
   1. Added new targets to the main make(1) file. 
   2. Fixed bug introduced while updating to MPI STREAM 1.7 with
   spurious global communicator (reported by NEC). 
   3. Added make(1) file for OpenMPI from MacPorts. 
   4. Fixed bug introduced while updating to MPI STREAM 1.7 that caused
   some ranks to use NULL communicator. 
   5. Fixed bug introduced while updating to MPI STREAM 1.7 that caused
   syntax errors. 
  


5.3  Version 1.5.0alpha (2015-05-22)
====================================
   
  
   1. Added global error accounting in STREAM. 
   2. Updated checking to report from multiple MPI processes
   contributing to overall error. 
   3. Added barrier to make sure all processes enter STREAM kernel tests
   at the same time. 
   4. Updated naming conventions to match the original benchmark in
   STREAM. 
   5. Changed scaling constant to prevent verification from overflowing
   in STREAM. 
   6. Simplified MPI communicator code in STREAM. 
   7. Substituted large constants for more descriptive compile time
   arithmetic in STREAM. 
   8. Added the "restrict" keyword to the STREAM vector pointers for
   faster generated code. 
   9. Updated STREAM code to the official STREAM MPI version 1.7. 
   10. Removed infinite loop due to default compiler optimization in
   DLAMCH and SLAMCH. 
   11. Added compiler flags to allow compiling with a C++ compiler. 
  


5.4  Version 1.4.3 (2013-08-26)
===============================
   
  
   1. Increased the size of scratch vector for local FFT tests that was
   missed in the previous version (reported by SGI). 
   2. Added Makefile for Blue Gene/P contributed by Vasil Tsanov. 
  


5.5  Version 1.4.2 (2012-10-12)
===============================
   
  
   1. Increased sizes of scratch vectors for local FFT tests to account
   for runs on systems with large main memory (reported by IBM, SGI and
   Intel). 
   2. Reduced vector size for local FFT tests due to larger scratch
   space needed. 
   3. Added a type cast to prevent overflow of a 32-bit integer vector
   size in FFT data generation routine (reported by IBM). 
   4. Fixed variable types to handle array sizes that overflow 32-bit
   integers in RandomAccess (reported by IBM and SGI). 
   5. Changed time-bound code to be used by default in Global
   RandomAccess and allowed for it to be switched off with a compile
   time flag if necessary. 
   6. Code cleanup to allow compilation without warnings of RandomAccess
   test. 
   7. Changed communication code in PTRANS to avoid large message sizes
   that caused problems in some MPI implementations. 
   8. Updated documentation in README.txt and README.html files. 
  


5.6  Version 1.4.1 (2010-06-01)
===============================
   
  
   1. Added optimized variants of RandomAccess that use Linear
   Congruential Generator for random number generation. 
   2. Made corrections to comments that provide definition of the
   RandomAccess test. 
   3. Removed initialization of the main array from the timed section of
   optimized versions of RandomAccess. 
   4. Fixed the length of the vector used to compute error when using
   MPI implementation from FFTW. 
   5. Added global reduction to error calculation in MPI FFT to achieve
   more accurate error estimate. 
   6. Updated documentation in README. 
  


5.7  Version 1.4.0 (2010-03-26)
===============================
   
  
   1. Added new variant of RandomAccess that uses Linear Congruential
   Generator for random number generation. 
   2. Rearranged the order of benchmarks so that HPL component runs last
   and may be aborted if the performance of other components was not
   satisfactory. RandomAccess is now first to assist in tuning the code.
   
   3. Added global initialization and finalization routine that allows
   to properly initialize and finalize external software and hardware
   components without changing the rest of the HPCC testing harness. 
   4. Lack of hpccinf.txt is no longer reported as error but as a
   warning. 
  


5.8  Version 1.3.2 (2009-03-24)
===============================
   
  
   1. Fixed memory leaks in G-RandomAccess driver routine. 
   2. Made the check for 32-bit vector sizes in G-FFT optional. MKL
   allows for 64-bit vector sizes in its FFTW wrapper. 
   3. Fixed memory bug in single-process FFT. 
   4. Update documentation (README). 
  


5.9  Version 1.3.1 (2008-12-09)
===============================
   
  
   1. Fixed a dead-lock problem in FFT component due to use of wrong
   communicator. 
   2. Fixed the 32-bit random number generator in PTRANS that was using
   64-bit routines from HPL. 
  


5.10  Version 1.3.0 (2008-11-13)
================================
   
  
   1. Updated HPL component to use HPL 2.0 source code 
     
      1. Replaced 32-bit Pseudo Random Number Generator (PRNG) with a
      64-bit one. 
      2. Removed 3 numerical checks of the solution residual with a
      single one. 
      3. Added support for 64-bit systems with large memory sizes
      (before they would overflow during index calculations 32-bit
      integers.) 
  
   2. Introduced a limit on FFT vector size so they fit in a 32-bit
   integer (only applicable when using FFTW version 2.) 
  


5.11  Version 1.2.0 (2007-06-25)
================================
  
  
  
   1. Changes in the FFT component: 
     
      1. Added flexibility in choosing vector sizes and processor
      counts: now the code can do powers of 2, 3, and 5 both
      sequentially and in parallel tests. 
      2. FFTW can now run with ESTIMATE (not just MEASURE) flag: it
      might produce worse performance results but often reduces time to
      run the test and cuases less memory fragmentation. 
  
   2. Changes in the DGEMM component: 
     
      1. Added more comprehensive checking of the numerical properties
      of the test's results. 
  
   3. Changes in the RandomAccess component: 
     
      1. Removed time-bound functionality: only runs that perform
      complete computation are now possible. 
      2. Made the timing more accurate: main array initialization is not
      counted towards performance timing. 
      3. Cleaned up the code: some non-portable C language constructs
      have been removed. 
      4. Added new algorithms: new algorithms from Sandia based on
      hypercube network topology can now be chosen at compile time which
      results on much better performance results on many types of
      parallel systems. 
      5. Fixed potential resource leaks by adding function calls rquired
      by the MPI standard. 
  
   4. Changes in the HPL component: 
     
      1. Cleaned up reporting of numerics: more accurate printing of
      scaled residual formula. 
  
   5. Changes in the PTRANS component: 
     
      1. Added randomization of virtual process grids to measure
      bandwidth of the network more accurately. 
  
   6. Miscellaneous changes: 
     
      1. Added better support for Windows-based clusters by taking
      advantage of Win32 API. 
      2. Added custom memory allocator to deal with memory fragmentation
      on some systems. 
      3. Added better reporting of configuration options in the output
      file. 
  
  


5.12  Version 1.0.0 (2005-06-11)
================================
  


5.13  Version 0.8beta (2004-10-19)
==================================
  


5.14  Version 0.8alpha (2004-10-15)
===================================
  


5.15  Version 0.6beta (2004-08-21)
==================================
  


5.16  Version 0.6alpha (2004-05-31)
===================================
  


5.17  Version 0.5beta (2003-12-01)
==================================
  


5.18  Version 0.4alpha (2003-11-13)
===================================
  


5.19  Version 0.3alpha (2004-11-05)
===================================
  
-----------------------------------------------------------------------
  
   This document was translated from LaTeX by HeVeA (2).
-----------------------------------
  
  
 (1) University of Tennessee Knoxville, Innovative Computing Laboratory
 (2) http://hevea.inria.fr/index.html
