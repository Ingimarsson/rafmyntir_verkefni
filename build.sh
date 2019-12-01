#!/bin/bash

cat task*.rst > final.rst
rst2pdf final.rst
xdg-open final.pdf
