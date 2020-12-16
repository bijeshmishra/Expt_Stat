/* SPLITPLOT CRD DESEIGN */
PROC GLIMMIX DATA = splitcard PLOTS = RESIDUALPANEL;
CLASS Wptrt Sptrt Wpexpunit;
MODEL response = wptrt sptrt wptrt*sptrt/DDFM = SATTERTH;
RANDOM Wpexpunit(wptrt);
LSMEANS ...;
CONTRAST ...;
ESTIMATE ...;
RUN;
QUIT;
