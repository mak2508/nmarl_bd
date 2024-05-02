### Usages
## Install Dependencies
1. Setup virtual environment
~~~
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
~~~

2. Install SUMO
- Please follow instructions [here](https://sumo.dlr.de/docs/Installing/index.html) 
- Make sure to update `SUMO_HOME` and `PYTHONPATH`. On mac, this can be done by
 appending to your `~/.bashrc`/`~/.zshrc` the following:
~~~
export SUMO_HOME=/usr/local/opt/sumo/share/sumo
export PYTHONPATH=$SUMO_HOME/tools:$PYTHONPATH
~~~
Then, run
~~~
source ~/.zshrc
~~~


## Experiments
There are 4 different experimental setups, 2 for each of Adaptive Traffic Signal Control (ATSC) and Cooperative Adaptive Cruise Control (CACC):
1. ATSC Grid
2. ATSC Monacco
3. CACC Catch-up
4. CACC Slow-down

In ATSC, the goal is to minimize traddic congestion based on real-time road-traffic measurements. The grid setting is a synthetic 5x5 grid, whereas the Monaco setting is a real-world 28-instersection traffic network from Monaco city. We have included instructions on getting started with the grid setting [below](#run-atsc-grid-example).

In CACC, the objective is to adaptively coordinate a platoon of vehicles to minimize car-following headway and speed perturbations based on real-time vehicle-to-vehicle communication.


## Run ATSC-grid example
This is a simple, 5x5 grid example for Adaptive Traffic Signal Control (traffic lights).
1. Generate SUMO files
~~~
(cd envs/large_grid_data && python build_file.py)
~~~

2. Create directory for experiment
~~~
mkdir -p ./experiments/atsc_grid1
~~~

3. Generate SUMO network files for grid environment
~~~
(cd envs/large_grid_data && python build_file.py)
~~~

4. Run experiment
~~~
python3 main.py --base-dir experiments/atsc_grid1 train --config-dir config/config_ia2c_grid.ini
~~~

4. (optional) View training progress on Tensorboard
~~~
tensorboard --logdir=experiments/atsc_grid1/log
~~~
You can find the dashboard at http://localhost:6006/ 