#!/usr/bin/env python3

reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT', 'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']

graph = set()
k = 3

for read in reads:
    for i in range(len(read)-k):
        kmer1 = read[i:i+k]
        kmer2 = read[i+1:i+k+1]
        graph.add(f"{kmer1} -> {kmer2}")

print("digraph {")
for edge in graph:
    print(f"    {edge};")
print("}")

# Command in terminal is `./graphViz.py | dot -Tpng > ex2_digraph.png`