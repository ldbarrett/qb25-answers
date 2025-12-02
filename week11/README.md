## 1.1
1Mbp genome to 3x coverage is 3 million bases total. 3 million divided by 100bp is 30,000 100bp reads

## 1.4
1. 50,332 bases have 0 reads at 3x coverage (from one run of the simulation)
2. This aligns well with Poisson expectations, which predicted 49700 empty bases (~1.2% percent error). The normal distribution estimate was not far off, but it was further than the Poisson prediction, at ~51,300 (~1.9% percent error). Visually, it also appears that the Poisson curve fits the histogram better than the Normal curve

## 1.5
1. 53 bases have 0 reads at 10x coverage
2. Poisson still fits better, predicting 48 empty bases to the Normal estimate of 80

## 1.6
1. 4 empty bases at 30x coverage
2. This is notably higher than both Poisson and Normal distributions. The poisson prediction yields an expected number of empty bases of order 10^-8, while the Normal Distribution's prediction is of order 10^-2. In this case, it seems the Normal distribution is a better descriptor of the coverage, but both are less accurate than in the lower coverage cases.

## 2.4
Command in terminal is `./graphViz.py | dot -Tpng > ex2_digraph.png`

## 2.5
Path: ATT  > TTG > TGA > GAT > ATT > TTC > TCA > CAT > ATT > TTC > TCT > CTT > TTA > TAT > ATT > TTT
Sequence: ATTGATTCATTCTTATTT

## 2.6
We would need to know how long the final sequence is, as well as useful information estimating the abundance of repetitive regions (like 'ATT' in our de Bruijn graph). These could fix some ends of our graph and help us limit the possible number of sequences down to 1.