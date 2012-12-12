#!/usr/bin/env python
"""
 Write trees under various demogrpahic histories. Values are other than the 
 one that is varied (i.e. divergence time or mirgration rate) are hard-coded
 first number after 'ms' is number of individuals, next the number of 
 simulations.

 Usage: $make_samples.py [num. of reps] [divergence/migration/both] 

"""

import sys
import subprocess

base_gsi = 'ms 40 {0} -I 4 10 10 10 10 -T -ej {1} 2 1 -ej 5 3 4 -ej 5 4 1 > trees/gsi_{0}.tre'

base_mig = 'ms 30 {0} -T -I 3 10 10 10 0 -ej 4 2 1 -ej 4 3 1 -m 2 3 {1} > trees/migration_{0}.tre'

def main(n=500, divergence=True, migration=True):
    #very hacky way of making a range of floats:

    if divergence:
        for theta in (i/20.0 for i in range(1,21)):
            cmd = base_gsi.format(n, theta)
            subprocess.call(cmd, shell=True)
        print 'wrote trees for divergence'

    if migration:
        for Nm in [0.01, 0.1, 1, 10, 25, 100]:
            cmd = base_mig.format(n, Nm)
            subprocess.call(cmd, shell=True)
        print 'write trees for migration'

if __name__ == "__main__":
    try:
        runs, arg = sys.argv[2]
    except IndexError:
        sys.exit("Missing command line argument, needs to be one of 'divergence', migration' or 'both'")
    if arg == "both":
        main(n=runs)
    elif arg == "divergence":
        main(n=runs, migration=False)
    elif arg == "migration":
        main(n=runs, divergence=False)
    else:
        sys.exit("Don't know how to deal with arguments '{0}'".format(arg))
  
