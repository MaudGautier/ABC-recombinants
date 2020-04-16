# ABC-recombinants

## Description

### Overview 

This repository contains the approximate bayesian computation (ABC) analysis allowing to infer the true conversion tract length of COs and NCOs and the true ratio of CO:NCO.

In short, an ABC consists in creating a simulator that reproduces at best the biological experiment, performing a large number of simulations with variable input parameters and assessing which range of values are biologically relevant by confronting the summary statistics representative of the output of the simulations to the biological observations.


### Simulator 

In this case, we thus built a simulator that mimicked the formation of recombination events, their sequencing and their genotyping. 
The source code of the simulator is [the `simulate-recombinants-in-hotspots` repository](https://github.com/MaudGautier/simulate-recombinants-in-hotspots).


### Selection of the simulations compatible with the experimental data

To infer the true recombination parameters, the simulations whose results are close to those of the biological experiment need to be summarised into a set of summary statistics. 
In this case, the summary statistics are:

* the observed Rec-1S:Rec-2S ratio <img src="https://render.githubusercontent.com/render/math?math=r_{Rec-1S:Rec-2S}^{obs}">, 
* the observed mean and quartiles of Rec-1S <img src="https://render.githubusercontent.com/render/math?math=CT^{\star}"> lengths (<img src="https://render.githubusercontent.com/render/math?math=l_{Rec-1S}^{mean}">, <img src="https://render.githubusercontent.com/render/math?math=l_{Rec-1S}^{0.25}">, <img src="https://render.githubusercontent.com/render/math?math=l_{Rec-1S}^{0.5}">, <img src="https://render.githubusercontent.com/render/math?math=l_{Rec-1S}^{0.75}">) 
* the observed mean and quartiles of Rec-2S <img src="https://render.githubusercontent.com/render/math?math=CT^{\star}"> lengths (<img src="https://render.githubusercontent.com/render/math?math=l_{Rec-2S}^{mean}">, <img src="https://render.githubusercontent.com/render/math?math=l_{Rec-2S}^{0.25}">, <img src="https://render.githubusercontent.com/render/math?math=l_{Rec-2S}^{0.5}">, <img src="https://render.githubusercontent.com/render/math?math=l_{Rec-2S}^{0.75}">).

 
We then used [the R package `abc`](https://cran.r-project.org/web/packages/abc/index.html) described in [Csilléry et al., 2012](https://besjournals.onlinelibrary.wiley.com/doi/full/10.1111/j.2041-210X.2011.00179.x) to select the simulated datasets 
<img src="https://render.githubusercontent.com/render/math?math=\mathcal{D}^{*}"> that ended in summary statistics 
<img src="https://render.githubusercontent.com/render/math?math=\mathcal{S}^{*}"> close to the summary statistics 
<img src="https://render.githubusercontent.com/render/math?math=\mathcal{S}"> of the experimental dataset 
<img src="https://render.githubusercontent.com/render/math?math=\mathcal{D}">, with a tolerance threshold (
<img src="https://render.githubusercontent.com/render/math?math=\epsilon">) of 5\% (i.e.\ 
<img src="https://render.githubusercontent.com/render/math?math=\mathcal{D}^{*}"> was retained if 
<img src="https://render.githubusercontent.com/render/math?math=d(\mathcal{S}^{*}, \mathcal{S}) \leq \epsilon">).

This allows to infer the values of the parameters of interest, namely: the CO CT length mean
<img src="https://render.githubusercontent.com/render/math?math=m_{CO}"> and standard deviation 
<img src="https://render.githubusercontent.com/render/math?math=sd_{CO}">, the NCO CT length mean
<img src="https://render.githubusercontent.com/render/math?math=m_{NCO}"> and standard deviation
<img src="https://render.githubusercontent.com/render/math?math=sd_{NCO}">, and the CO:NCO ratio
<img src="https://render.githubusercontent.com/render/math?math=r_{CO:NCO}">.

## References

This workflow rests mostly on [the R package `abc`](https://cran.r-project.org/web/packages/abc/index.html) described in this paper:

> Csilléry, K., François, O., and Blum, M. G. B. (2012). Abc: An R package for approximate Bayesian computation (ABC). Methods in Ecology and Evolution, 3(3):475–479.



