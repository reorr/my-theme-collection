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


if __name__ == '__main__':
    ASSET_LST = 'listassets.txt'
    SVG_FILE = 'assets.svg'
    ASSET_DIR = 'assets/'
    DEVNULL = open(os.devnull, 'w')
    num_core =multiprocessing.cpu_count()
    with open(ASSET_LST,'r') as ass_txt:
        ids = []
        for line in ass_txt:
            line = line.rstrip()
            ids.append(line)

    with Pool(num_core) as p:
        p.map(run_inkscape, ids)

    cp_cmds = """cp {ASSET_DIR}entry-toolbar.png menubar-toolbar/entry-toolbar.png
cp {ASSET_DIR}entry-active-toolbar.png menubar-toolbar/entry-active-toolbar.png
cp {ASSET_DIR}entry-disabled-toolbar.png menubar-toolbar/entry-disabled-toolbar.png
cp {ASSET_DIR}entry-toolbar.png menubar-toolbar/entry-toolbar-dark.png
cp {ASSET_DIR}entry-active-toolbar.png menubar-toolbar/entry-active-toolbar-dark.png
cp {ASSET_DIR}entry-disabled-toolbar.png menubar-toolbar/entry-disabled-toolbar-dark.png
cp {ASSET_DIR}menubar.png menubar-toolbar/menubar.png
cp {ASSET_DIR}menubar_button.png menubar-toolbar/menubar_button.png
cp {ASSET_DIR}menubar.png menubar-toolbar/menubar-dark.png
cp {ASSET_DIR}menubar_button.png menubar-toolbar/menubar_button-dark.png
cp {ASSET_DIR}button.png menubar-toolbar/button.png
cp {ASSET_DIR}button-active.png menubar-toolbar/button-active.png
cp {ASSET_DIR}button-hover.png menubar-toolbar/button-hover.png
cp {ASSET_DIR}button-insensitive.png menubar-toolbar/button-insensitive.png""".format(ASSET_DIR=ASSET_DIR)

#    print(cp_cmds.split('\n'))
    for cmd in cp_cmds.split('\n'):
        subprocess.call(cmd.split())

    DEVNULL.close()




