#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jan 18 19:19:18 2019

@author: lcoyle
"""
import multiprocessing
import subprocess
import os
from multiprocessing import Pool



def run_inkscape(obj_id):
    print('rendering {}'.format(obj_id))
    subprocess.call(['/usr/bin/inkscape',
                     '--export-id={}'.format(obj_id),
                     '--export-id-only',
                     '--export-png={}{}.png'.format(ASSET_DIR, obj_id),
                     '{}'.format(SVG_FILE)], stdout=DEVNULL, stderr=subprocess.STDOUT)
    subprocess.call(['/usr/bin/optipng',
                     '-o7',
                     '--quiet',
                     '{}{}.png'.format(ASSET_DIR, obj_id)])

    subprocess.call(['/usr/bin/inkscape',
                     '--export-id={}'.format(obj_id),
                     '--export-dpi=180',
                     '--export-id-only',
                     '--export-png={}{}@2.png'.format(ASSET_DIR, obj_id),
                     '{}'.format(SVG_FILE)], stdout=DEVNULL, stderr=subprocess.STDOUT)
    subprocess.call(['/usr/bin/optipng',
                     '-o7',
                     '--quiet',
                     '{}{}@2.png'.format(ASSET_DIR, obj_id)])

if __name__ == '__main__':
    ASSET_LST = 'assets.txt'
    SVG_FILE = 'assets.svg'
    ASSET_DIR = 'assets/'
    DEVNULL = open(os.devnull, 'w')
    num_cores = multiprocessing.cpu_count()
    with open(ASSET_LST,'r') as ass_txt:
        ids = []
        for line in ass_txt:
            line = line.rstrip()
            ids.append(line)

    with Pool(num_cores) as p:
        p.map(run_inkscape, ids)

    DEVNULL.close()




