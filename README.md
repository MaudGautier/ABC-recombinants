# ABC-recombinants

## Overview 

This repository contains the approximate bayesian computation (ABC) analysis allowing to infer the true conversion tract length of COs and NCOs and the true ratio of CO:NCO.

In short, an ABC consists in creating a simulator that reproduces at best the biological experiment, per- forming a large number of simulations with variable input parameters and assessing which range of values are biologically relevant by confronting the summary statistics
representative of the output of the simulations to the biological observations.

In this case, we thus built a simulator that mimicked the formation of recombination events, their sequencing and their genotyping. 
The source code of the simulator is [the `simulate-recombinants-in-hotspots` repository](https://github.com/MaudGautier/simulate-recombinants-in-hotspots).





## Credits

This workflow uses [the R package `abc`](https://cran.r-project.org/web/packages/abc/index.html) described in [Csilléry et al., 2012](https://besjournals.onlinelibrary.wiley.com/doi/full/10.1111/j.2041-210X.2011.00179.x).



