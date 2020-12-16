Bijesh Mishra
STAT 5023 Statistics for Experimenters II (With Complete Data and Analysis)
SAS Assignment I
SAS CODE:
*** Filename: STAT 5023: Assignment 1.sas ***
TITLE 'STAT 5023: Assignment 1';
DM 'LOG; CLEAR; ODSRESULTS; CLEAR;';
OPTIONS LS = 80 PAGENO = 1;
DATA metal;
INPUT supplier tenstren @@;
CARDS;
1 21.1 1 24.6 1 26.2 1 22.9
2 27.3 2 30.3 2 24.2 2 29.9
3 31.8 3 30.0 3 21.9 3 25.1
4 26.9 4 26.9 4 12.7 4 15.5
5 8.08 5 18.9 5 31.4 5 27.1
;
* PROC PRINT DATA = metal;
TITLE 'ANOVA, HOVS (LEVENE AND BARTLETT), MEANS, STANDARD DEVIATIONS, PLOTS';

PROC GLM DATA = metal ALPHA = 0.02 PLOTS = (BOXPLOT RESIDUALS DIAGNOSTICS);
CLASS supplier;
MODEL tenstren = supplier;
MEANS supplier / HOVTEST = LEVENE (TYPE = ABS)HOVTEST = BARTLETT ALPHA = 0.02;

PROC MIXED DATA = metal PLOTS = RESIDUALPANEL;
CLASS supplier;
MODEL tenstren = supplier /DDFM = SATTERTH;
REPEATED / GROUP = supplier;
LSMEANS supplier;
TITLE MIXED Procedure When the Variances are Unequal;
;
RUN;
QUIT;

SAS Assignment II
SAS CODE:
DM 'LOG; CLEAR; ODSRESULTS; CLEAR; ';
DATA sas2; INPUT coating wear @@;
LABEL coating ='Layers of Coating' wear='Wear';
DATALINES;
0 21.0434 1 17.0270 2 13.2604 3 13.2798 4 13.9394
0 23.7164 1 15.1824 2 16.0983 3 14.6028 4 09.0165
0 26.3993 1 16.1865 2 15.1277 3 12.7176 4 15.5906
0 25.5745 1 15.2647 2 14.3230 3 11.7969 4 11.2414
0 23.2901 1 14.7997 2 14.5364 3 10.6507 4 10.0621
0 26.6883 1 16.0777 2 16.0863 3 14.3297 4 10.4367
0 24.8230 1 14.5333 2 13.7632 3 09.4774 4 13.6440
;
TITLE "ANOVA, Control Vs Rest, Tukey  Comparison, Trend Analysis, CI: 0.02";
PROC GLM DATA = sas2 PLOTS = NONE;
CLASS coating;
MODEL wear = coating;
/* Simultaneous Contrast: Method 1.1: SS != SSH0*/
CONTRAST '1 = 2'		 		coating 0 1 -1 0 0;  
CONTRAST '1 + 2 = 2*3'			coating 0 1 0 -1 0;
CONTRAST '1 + 2 + 3 = 3*4'		coating 0 1 0 0 -1;
/* Simultaneous Contrast: Method 1.2 (~ Method 1.1)*/
CONTRAST 'M1.2: 1 = 2 = 3 = 4 ' 		coating 0 1 -1 0 0,  
    							coating 0 1 0 -1 0,
			         			coating 0 1 0 0 -1;

/* Simultaneous Contrast: Method 2.1: SS = SSH0*/
CONTRAST '1 = 2'		 		coating 0 1 -1 0 0;  
CONTRAST '1 + 2 = 2*3'			coating 0 1 1 -2 0;
CONTRAST '1 + 2 + 3 = 3*4'		coating 0 1 1 1 -3;
/* Simultaneous Contrast: Method 2.2 (~ Method 2.1)*/
CONTRAST ' M2.2: 1 = 2 = 3 = 4 ' 		coating 0 1 -1 0 0,  
    							coating 0 1 1 -2 0,
			         			coating 0 1 1 1 -3;
TITLE3 'Simultaneous Contrast: Single Test, mean difference, Non Control Trts';
RUN; QUIT;
PROC GLM DATA = sas2 PLOTS = (BOXPLOT);
CLASS coating;
MODEL wear = coating;
/* Tukey Comparison of the Means */
MEANS coating / ALPHA = 0.02 LINES TUKEY CLDIFF;
/* Trend Values from Book Page 740. t = 5 */
CONTRAST "Linear Trend (x1)"	 		coating 		-2 -1 0 1 2;
CONTRAST "Quadratic Trend (x2)" 		coating 		2 -1 -2 -1 2;
CONTRAST "Cubic Trend (x3)" 			coating		-1 2 0 -2 1;
CONTRAST "Quartic Trend/LoF (x4)"		coating		1 -4 6 -4 1;
LSMEANS coating /STDERR;
TITLE3 ' Tukey Comparison of Mean and Trend Analysis'; RUN; QUIT;
PROC GPLOT DATA = sas2;
PLOT wear*coating / VAXIS = 8 12 16 20 24 28 HAXIS = 0 1 2 3 4; 
SYMBOL1 VALUE = # CV = RED I = NONE;
TITLE2 ' Trend Analysis Using GPLOT'; RUN; QUIT;

PROC SGPLOT DATA = sas2;
SCATTER Y = wear X = coating;
TITLE2 "SGPLOT option for Statistical Graphing"; RUN; QUIT;

SAS LOG:
747  DM 'LOG; CLEAR; ODSRESULTS; CLEAR; ';
748  DATA sas2; INPUT coating wear @@;
749  LABEL coating ='Layers of Coating' wear='Wear';
750  DATALINES;

NOTE: SAS went to a new line when INPUT statement reached past the end of a line.
NOTE: The data set WORK.SAS2 has 35 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.01 seconds
      cpu time            0.01 seconds

758  ;
759  TITLE "ANOVA, Control Vs Rest, Tukey  Comparison, Trend Analysis, CI: 0.02";
760  PROC GLM DATA = sas2 PLOTS = NONE;
761  CLASS coating;
762  MODEL wear = coating;
763  /* Simultaneous Contrast: Method 1.1: SS != SSH0*/
764  CONTRAST '1 = 2'                coating 0 1 -1 0 0;
765  CONTRAST '1 + 2 = 2*3'          coating 0 1 0 -1 0;
766  CONTRAST '1 + 2 + 3 = 3*4'      coating 0 1 0 0 -1;
767  /* Simultaneous Contrast: Method 1.2 (~ Method 1.1)*/
768  CONTRAST 'M1.2: 1 = 2 = 3 = 4 '         coating 0 1 -1 0 0,
769                                          coating 0 1 0 -1 0,
770                                          coating 0 1 0 0 -1;
771
772  /* Simultaneous Contrast: Method 2.1: SS = SSH0*/
773  CONTRAST '1 = 2'                coating 0 1 -1 0 0;
774  CONTRAST '1 + 2 = 2*3'          coating 0 1 1 -2 0;
775  CONTRAST '1 + 2 + 3 = 3*4'      coating 0 1 1 1 -3;
776  /* Simultaneous Contrast: Method 2.2 (~ Method 2.1)*/
777  CONTRAST ' M2.2: 1 = 2 = 3 = 4 '        coating 0 1 -1 0 0,
778                                          coating 0 1 1 -2 0,
779                                          coating 0 1 1 1 -3;
780  TITLE3 'Simultaneous Contrast: Single Test, mean difference, Non Control Trts';
781  RUN;

NOTE: Writing HTML Body file: sashtml15.htm
781!      QUIT;

NOTE: PROCEDURE GLM used (Total process time):
      real time           1.08 seconds
      cpu time            0.45 seconds

782  PROC GLM DATA = sas2 PLOTS = (BOXPLOT);
783  CLASS coating;
784  MODEL wear = coating;
785  /* Tukey Comparison of the Means */
786  MEANS coating / ALPHA = 0.02 LINES TUKEY CLDIFF;
787  /* Trend Values from Book Page 740. t = 5 */
788  CONTRAST "Linear Trend (x1)"            coating     -2 -1 0 1 2;
789  CONTRAST "Quadratic Trend (x2)"         coating     2 -1 -2 -1 2;
790  CONTRAST "Cubic Trend (x3)"             coating     -1 2 0 -2 1;
791  CONTRAST "Quartic Trend/LoF (x4)"       coating     1 -4 6 -4 1;
792  LSMEANS coating /STDERR;
793  TITLE3 ' Tukey Comparison of Mean and Trend Analysis'; RUN;

793!                                                             QUIT;

NOTE: PROCEDURE GLM used (Total process time):
      real time           2.27 seconds
      cpu time            0.87 seconds

794  PROC GPLOT DATA = sas2;
795  PLOT wear*coating / VAXIS = 8 12 16 20 24 28 HAXIS = 0 1 2 3 4;
796  SYMBOL1 VALUE = # CV = RED I = NONE;
797  TITLE2 ' Trend Analysis Using GPLOT'; RUN;

NOTE: 18542 bytes written to C:\Users\bmishra\AppData\Local\Temp\SAS Temporary
      Files\_TD93932_NREM-9HTXG02_\gplot15.png.
797!                                            QUIT;

NOTE: There were 35 observations read from the data set WORK.SAS2.
NOTE: PROCEDURE GPLOT used (Total process time):
      real time           0.30 seconds
      cpu time            0.14 seconds

798
799  PROC SGPLOT DATA = sas2;
800  SCATTER Y = wear X = coating;
801  TITLE2 "SGPLOT option for Statistical Graphing"; RUN;

801!                                                       QUIT;
NOTE: PROCEDURE SGPLOT used (Total process time):
      real time           0.55 seconds
      cpu time            0.04 seconds

NOTE: There were 35 observations read from the data set WORK.SAS2.


Complete SAS Code:
DM 'LOG; CLEAR; ODSRESULTS; CLEAR; ';
DATA sas2; INPUT coating wear @@;
LABEL coating ='Layers of Coating' wear='Wear';
DATALINES;
0 21.0434 1 17.0270 2 13.2604 3 13.2798 4 13.9394
0 23.7164 1 15.1824 2 16.0983 3 14.6028 4 09.0165
0 26.3993 1 16.1865 2 15.1277 3 12.7176 4 15.5906
0 25.5745 1 15.2647 2 14.3230 3 11.7969 4 11.2414
0 23.2901 1 14.7997 2 14.5364 3 10.6507 4 10.0621
0 26.6883 1 16.0777 2 16.0863 3 14.3297 4 10.4367
0 24.8230 1 14.5333 2 13.7632 3 09.4774 4 13.6440
;
TITLE "ANOVA, Tukey  Comparison, Trend Analysis: Control Vs Rest, CI: 0.02";
PROC PRINT DATA = sas2;
TITLE2 'Data Set';

PROC GLM DATA = sas2 PLOTS = NONE;
CLASS coating;
MODEL wear = coating;
/* Single Test of differences of non-zero layer coating */
/* Simultaneous Contrast: Method 1.1: SS != SSH0*/
CONTRAST '1 = 2'		 		coating 0 1 -1 0 0;  
CONTRAST '1 + 2 = 2*3'			coating 0 1 0 -1 0;
CONTRAST '1 + 2 + 3 = 3*4'		coating 0 1 0 0 -1;
/* Simultaneous Contrast: Method 1.2 (~ Method 1.1)*/
CONTRAST 'M1.2: 1 = 2 = 3 = 4 ' 		coating 0 1 -1 0 0,  
    							coating 0 1 0 -1 0,
			         			coating 0 1 0 0 -1;

/* Simultaneous Contrast: Method 2.1: SS = SSH0*/
CONTRAST '1 = 2'		 		coating 0 1 -1 0 0;  
CONTRAST '1 + 2 = 2*3'			coating 0 1 1 -2 0;
CONTRAST '1 + 2 + 3 = 3*4'		coating 0 1 1 1 -3;
/* Simultaneous Contrast: Method 2.2 (~ Method 2.1)*/
CONTRAST ' M2.2: 1 = 2 = 3 = 4 ' 		coating 0 1 -1 0 0,  
  							coating 0 1 1 -2 0,
	         					coating 0 1 1 1 -3;
TITLE3 'Simultaneous Contrast: Single Test, mean difference, Non Control Trts'; RUN; QUIT;

PROC GLM DATA = sas2 PLOTS = (RESIDUALS DIAGNOSTICS RESIDUALS);
CLASS coating;
MODEL wear = coating;
/* Tukey Comparison of the Means */
LSMEANS coating / STDERR ADJUST = TUKEY LINES ALPHA = 0.02;
MEANS coating / HOVTEST = LEVENE (TYPE = ABS) HOVTEST = BARTLETT ALPHA = 0.02 LINES LSD SCHEFFE TUKEY CLM CLDIFF;
TITLE2 'Mean Statements, Tukey Comparison, HOV Tests';

/* Trend Values from Book Page 740. t = 5 */
CONTRAST "Linear Trend (x1)"	 		coating 	-2 -1 0 1 2;
CONTRAST "Quadratic Trend (x2)" 		coating 	2 -1 -2 -1 2;
CONTRAST "Cubic Trend (x3)" 			coating	-1 2 0 -2 1;
CONTRAST "Quartic Trend/LoF (x4)"		coating	1 -4 6 -4 1;
LSMEANS coating / STDERR;
TITLE2 'Trend Analysis using Various Degree Trend'; RUN; QUIT;

PROC GPLOT DATA = sas2;
PLOT wear*coating / VAXIS = 8 12 16 20 24 28 HAXIS = 0 1 2 3 4; 
SYMBOL1 VALUE = # CV = RED I = NONE;
TITLE2 ' Trend Analysis Using GPLOT'; RUN; QUIT;

PROC SGPLOT DATA = sas2;
SCATTER Y = wear X = coating;
TITLE2 "SGPLOT option for Statistical Graphing"; RUN; QUIT;



SAS Assignment III
DM 'LOG; CLEAR; ODSRESULTS; CLEAR; ';
DATA sas3; 
INPUT center program gender $ subject wtloss @@;
DATALINES;
1 1 F 1 17.2299 5 1 F 1 11.6695 1 1 F 2 15.7648 5 1 F 2 12.1876
1 2 F 1 19.2342 5 2 F 1 11.6978 1 2 F 2 18.0468 5 2 F 2 10.0957
1 3 F 1 9.1973 5 3 F 1 7.4432 1 3 F 2 8.6906 5 3 F 2 5.9384
1 1 M 1 17.4656 5 1 M 1 10.9597 1 1 M 2 15.9233 5 1 M 2 11.2989
1 2 M 1 24.2613 5 2 M 1 18.3452 1 2 M 2 25.3422 5 2 M 2 18.1953
1 3 M 1 19.6999 5 3 M 1 17.3051 1 3 M 2 18.3468 5 3 M 2 17.2238
2 1 F 1 14.9102 6 1 F 1 16.4390 2 1 F 2 15.5265 6 1 F 2 16.9725
2 2 F 1 24.5785 6 2 F 1 26.3404 2 2 F 2 22.9297 6 2 F 2 25.6193
2 3 F 1 21.4465 6 3 F 1 23.5122 2 3 F 2 19.4496 6 3 F 2 20.7551
2 1 M 1 17.7488 6 1 M 1 19.4338 2 1 M 2 18.6772 6 1 M 2 16.2848
2 2 M 1 18.6206 6 2 M 1 19.9519 2 2 M 2 19.6741 6 2 M 2 22.5633
2 3 M 1 16.2433 6 3 M 1 17.4446 2 3 M 2 16.9580 6 3 M 2 19.0843
3 1 F 1 9.4561 7 1 F 1 10.1201 3 1 F 2 10.0818 7 1 F 2 10.9801
3 2 F 1 19.9627 7 2 F 1 15.4252 3 2 F 2 21.6687 7 2 F 2 14.9049
3 3 F 1 20.5674 7 3 F 1 16.3866 3 3 F 2 20.1926 7 3 F 2 17.3304
3 1 M 1 14.5206 7 1 M 1 13.9226 3 1 M 2 15.4205 7 1 M 2 14.7064
3 2 M 1 16.1217 7 2 M 1 25.6431 3 2 M 2 16.7883 7 2 M 2 25.9734
3 3 M 1 11.7393 7 3 M 1 20.9447 3 3 M 2 11.8407 7 3 M 2 21.4765
4 1 F 1 18.4680 8 1 F 1 11.4767 4 1 F 2 17.8540 8 1 F 2 12.4374
4 2 F 1 25.7911 8 2 F 1 34.4723 4 2 F 2 24.0275 8 2 F 2 34.6249
4 3 F 1 15.1685 8 3 F 1 20.8010 4 3 F 2 16.4565 8 3 F 2 20.3882
4 1 M 1 15.0173 8 1 M 1 25.4748 4 1 M 2 15.0015 8 1 M 2 25.3372
4 2 M 1 23.0530 8 2 M 1 25.1632 4 2 M 2 23.3327 8 2 M 2 25.9337
4 3 M 1 20.8105 8 3 M 1 19.9659 4 3 M 2 20.9137 8 3 M 2 20.9266
;
/* USING MIXED PROCEDURE METHOD =TYPE3 PRODUCES EXPECTED MEAN SQUARES */
TITLE3 "USING METHOD = TYPE3 PRODUCES EXPECTED MEAN SQUARES";
PROC MIXED DATA = sas3 METHOD = TYPE3; /* TYPE3 = Method of Moments */
CLASS center program gender subject; /* All Treatments */
MODEL wtloss = program | gender | subject ; /* Only Fixed Effects; DDFM = KR */
RANDOM center center*program center*gender center*subject; /* Random Statement */
LSMEANS program / PDIFF CL ALPHA = 0.01; /* Default ADJUST is F-LSD */
RUN; QUIT;

/* USING MIXED PROCEDURE, REML METHOD */
TITLE3 "USING MIXED PROCEDURE, METHOD = REML";
PROC MIXED DATA = sas3 METHOD = REML PLOT = RESIDUALPANEL; /* DEFAULT METHOD IS REML */
CLASS center program gender subject; /* All Treatments */
MODEL wtloss = program | gender | subject / DDFM = SATTERTH; /* Only Fixed Effects; DDFM = KR */
RANDOM center center*program center*gender center*subject; /* Random Component */
LSMEANS program / PDIFF CL ALPHA = 0.01; /* Default ADJUST is F-LSD */
RUN; QUIT;

SAS IV:
SAS CODE:
DM 'LOG; CLEAR; ODSRESULTS; CLEAR;';
TITLE 'Split plot Assignment 4 Height';
DATA sas4;
INPUT rep water color $ height width;
/* WP = Water, SP = Color, Blocks = Rep Response = height & Width */
DATALINES;
1 1 Red 10.4641 18.9764 
1 1 White 8.6361 18.5999
1 1 Coral 8.6836 17.6397
1 2 Red 11.2051 22.5655 
1 2 White 11.5241 21.1620
1 2 Coral 7.9262 16.5507
2 1 Red 15.3595 16.6630
2 1 White 14.7127 16.7290
2 1 Coral 13.4858 16.6223
2 2 Red 16.5188 20.3693 
2 2 White 15.3492 19.2496
2 2 Coral 13.1782 17.4857
3 1 Red 14.2442 13.8697
3 1 White 15.2705 12.3667
3 1 Coral 14.8693 10.9506
3 2 Red 14.1018 17.2177
3 2 White 13.8954 16.5381
3 2 Coral 10.4144 13.6593 
4 1 Red 11.4202 15.3572
4 1 White 8.4697 14.8884
4 1 Coral 8.6994 13.6597
4 2 Red 15.9493 20.9637
4 2 White 15.1878 21.5276
4 2 Coral 11.7707 17.3201
;
/* Height */
PROC GLIMMIX DATA=sas4 NOBOUND PLOTS = RESIDUALPANEL;
CLASS rep water color; /* Block, Whole Plot, Sub Plot */
MODEL height = water | color / DDFM=SATTERTH; /*WP SP WP*SP */
RANDOM rep rep*water; /*WPBlock WPBlock*SP */ 
LSMEANS water color / LINES ADJUST = TUKEY PDIFF; /* N/A IF SIGNIFICANT INTERACTION */
LSMEANS water*color / ADJUST = TUKEY LINES PDIFF SLICE =(water color) ALPHA = 0.05 PLOTS = MEANPLOT(SLICEBY = water JOIN);
RUN; QUIT;

PROC SORT DATA=sas4;
BY water color;

PROC MEANS DATA = sas4 NOPRINT;
BY water color;
VAR height;
OUTPUT OUT=plotdata1 MEAN = MeanYield1;
GOPTIONS FTEXT="Arial";

PROC GPLOT DATA = plotdata1 ;
PLOT meanyield1*water = color ; *Or, PLOT meanyield*trt=seed ;
TITLE3 'Interaction Plot'; 
SYMBOL1 VALUE=circle CV=BLUE I=join L=1 W=2 H=2;
SYMBOL2 VALUE=dot    CV=RED I=join L=3 W=2 H=2;
SYMBOL3 VALUE=square CV=GREEN I=join L=8 W=2 H=2;
RUN; QUIT;

TITLE 'Split plot Assignment 4 Width';
/* Width */
PROC GLIMMIX DATA=sas4 NOBOUND PLOTS = RESIDUALPANEL;
CLASS rep water color; /* Block, Whole Plot, Sub Plot */
MODEL width = water | color / DDFM=SATTERTH; /*WP SP WP*SP */
RANDOM rep rep*water; /*WPBlock WPBlock*SP */ 
LSMEANS water color / LINES ADJUST = TUKEY PDIFF; /* N/A IF SIGNIFICANT INTERACTION */
LSMEANS water*color / ADJUST = TUKEY LINES PDIFF SLICE =(water color) ALPHA = 0.05 PLOTS = MEANPLOT(SLICEBY = water JOIN);
RUN; QUIT;

PROC SORT DATA=sas4;
BY water color;

PROC MEANS DATA = sas4 NOPRINT;
BY water color;
VAR width;
OUTPUT OUT=plotdata2 MEAN = MeanYield2;
GOPTIONS FTEXT="Arial";

PROC GPLOT DATA = plotdata2 ;
PLOT meanyield2*water = color ; *Or, PLOT meanyield*trt=seed ;
TITLE3 'Interaction Plot'; 
SYMBOL1 VALUE=circle CV=BLUE I=join L=1 W=2 H=2;
SYMBOL2 VALUE=dot    CV=RED I=join L=3 W=2 H=2;
SYMBOL3 VALUE=square CV=GREEN I=join L=8 W=2 H=2;
RUN; QUIT;

SAS Log file:
1199  DM 'LOG; CLEAR; ODSRESULTS; CLEAR;';
1200  TITLE 'Split plot Assignment 4 Height';
1201  DATA sas4;
1202  INPUT rep water color $ height width;
1203  /* WP = Water, SP = Color, Blocks = Rep Response = height & Width */
1204  DATALINES;

NOTE: The data set WORK.SAS4 has 24 observations and 5 variables.
NOTE: DATA statement used (Total process time):
      real time           0.01 seconds
      cpu time            0.00 seconds


1229  ;
1230  /* Height */
NOTE: Writing HTML Body file: sashtml20.htm
1231  PROC GLIMMIX DATA=sas4 NOBOUND PLOTS = RESIDUALPANEL;
1232  CLASS rep water color; /* Block, Whole Plot, Sub Plot */
1233  MODEL height = water | color / DDFM=SATTERTH; /*WP SP WP*SP */
1234  RANDOM rep rep*water; /*WPBlock WPBlock*SP */
1235  LSMEANS water color / LINES ADJUST = TUKEY PDIFF; /* N/A IF SIGNIFICANT INTERACTION */
1236  LSMEANS water*color / ADJUST = TUKEY LINES PDIFF SLICE =(water color) ALPHA = 0.05 PLOTS =
1236! MEANPLOT(SLICEBY = water JOIN);
1237  RUN;


NOTE: With DDFM=SATTERTHWAITE or DDFM=KENWARDROGER, unadjusted p-values in tests are based on the
      degrees of freedom specific to that comparison. P-values that are adjusted for
      multiplicity, however, are by default based on the denominator degrees of freedom for the
      Type III test of the fixed effect. If you specify the ADJDFE=ROW option in the LSMEANS or
      LSMESTIMATE statement, the adjusted p-values take into account the row-wise degrees of
      freedom.
1237!      QUIT;


NOTE: Convergence criterion (ABSGCONV=0.00001) satisfied.
NOTE: PROCEDURE GLIMMIX used (Total process time):
      real time           2.88 seconds
      cpu time            1.31 seconds


1238
1239  PROC SORT DATA=sas4;
1240  BY water color;
1241

NOTE: There were 24 observations read from the data set WORK.SAS4.
NOTE: The data set WORK.SAS4 has 24 observations and 5 variables.
NOTE: PROCEDURE SORT used (Total process time):
      real time           0.02 seconds
      cpu time            0.00 seconds


1242  PROC MEANS DATA = sas4 NOPRINT;
1243  BY water color;
1244  VAR height;
1245  OUTPUT OUT=plotdata1 MEAN = MeanYield1;
1246  GOPTIONS FTEXT="Arial";
1247

NOTE: There were 24 observations read from the data set WORK.SAS4.
NOTE: The data set WORK.PLOTDATA1 has 6 observations and 5 variables.
NOTE: PROCEDURE MEANS used (Total process time):
      real time           0.10 seconds
      cpu time            0.03 seconds


1248  PROC GPLOT DATA = plotdata1 ;
1249  PLOT meanyield1*water = color ; *Or, PLOT meanyield*trt=seed ;
1250  TITLE3 'Interaction Plot';
1251  SYMBOL1 VALUE=circle CV=BLUE I=join L=1 W=2 H=2;
1252  SYMBOL2 VALUE=dot    CV=RED I=join L=3 W=2 H=2;
1253  SYMBOL3 VALUE=square CV=GREEN I=join L=8 W=2 H=2;
1254  SYMBOL4 VALUE=triangle CV=BLACK I=join L=42 W=2 H=2;
1255  RUN;

NOTE: 22013 bytes written to C:\Users\bmishra\AppData\Local\Temp\SAS Temporary
      Files\_TD10952_NREM-9HTXG02_\gplot21.png.
1255!      QUIT;

NOTE: There were 6 observations read from the data set WORK.PLOTDATA1.
NOTE: PROCEDURE GPLOT used (Total process time):
      real time           0.22 seconds
      cpu time            0.14 seconds


1256
1257  TITLE 'Split plot Assignment 4 Width';
1258  /* Width */
1259  PROC GLIMMIX DATA=sas4 NOBOUND PLOTS = RESIDUALPANEL;
1260  CLASS rep water color; /* Block, Whole Plot, Sub Plot */
1261  MODEL width = water | color / DDFM=SATTERTH; /*WP SP WP*SP */
1262  RANDOM rep rep*water; /*WPBlock WPBlock*SP */
1263  LSMEANS water color / LINES ADJUST = TUKEY PDIFF; /* N/A IF SIGNIFICANT INTERACTION */
1264  LSMEANS water*color / ADJUST = TUKEY LINES PDIFF SLICE =(water color) ALPHA = 0.05 PLOTS =
1264! MEANPLOT(SLICEBY = water JOIN);
1265  RUN;


NOTE: With DDFM=SATTERTHWAITE or DDFM=KENWARDROGER, unadjusted p-values in tests are based on the
      degrees of freedom specific to that comparison. P-values that are adjusted for
      multiplicity, however, are by default based on the denominator degrees of freedom for the
      Type III test of the fixed effect. If you specify the ADJDFE=ROW option in the LSMEANS or
      LSMESTIMATE statement, the adjusted p-values take into account the row-wise degrees of
      freedom.
1265!      QUIT;


NOTE: Convergence criterion (ABSGCONV=0.00001) satisfied.
NOTE: PROCEDURE GLIMMIX used (Total process time):
      real time           1.13 seconds
      cpu time            0.56 seconds


1266
1267  PROC SORT DATA=sas4;
1268  BY water color;
1269

NOTE: Input data set is already sorted, no sorting done.
NOTE: PROCEDURE SORT used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds


1270  PROC MEANS DATA = sas4 NOPRINT;
1271  BY water color;
1272  VAR width;
1273  OUTPUT OUT=plotdata2 MEAN = MeanYield2;
1274  GOPTIONS FTEXT="Arial";
1275

NOTE: There were 24 observations read from the data set WORK.SAS4.
NOTE: The data set WORK.PLOTDATA2 has 6 observations and 5 variables.
NOTE: PROCEDURE MEANS used (Total process time):
      real time           0.01 seconds
      cpu time            0.00 seconds

1276  PROC GPLOT DATA = plotdata2 ;
1277  PLOT meanyield2*water = color ; *Or, PLOT meanyield*trt=seed ;
1278  TITLE3 'Interaction Plot';
1279  SYMBOL1 VALUE=circle CV=BLUE I=join L=1 W=2 H=2;
1280  SYMBOL2 VALUE=dot    CV=RED I=join L=3 W=2 H=2;
1281  SYMBOL3 VALUE=square CV=GREEN I=join L=8 W=2 H=2;
1282  SYMBOL4 VALUE=triangle CV=BLACK I=join L=42 W=2 H=2;
1283  RUN;

NOTE: 26806 bytes written to C:\Users\bmishra\AppData\Local\Temp\SAS Temporary
      Files\_TD10952_NREM-9HTXG02_\gplot22.png.
1283!      QUIT;

NOTE: There were 6 observations read from the data set WORK.PLOTDATA2.
NOTE: PROCEDURE GPLOT used (Total process time):
      real time           0.19 seconds
      cpu time            0.12 seconds

