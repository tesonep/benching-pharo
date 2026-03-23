# Preparation

You need to create a python environment and activate it, you need to have python (tested with 3.14)

```bash
python3.14 -m venv .env
. .env/bin/activate
```

Then install the dependencies: rebench and matplotlib.

```bash
pip install rebench
pip install matplotlib
```
# To Run

Run just do: 

```bash
mkdir build
cd build/

../scripts/prepare.sh
../scripts/runAll.sh
```bash

All results will be in build/data and the plots in build/plots