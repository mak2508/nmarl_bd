## Usages
## Install Dependencies
1. Setup virtual environment
~~~
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
~~~

2. Install SUMO 
    1. Euler\
    If you are on Euler, installing SUMO from a binary does not work since you lack root privileges. Instead, please follow the following instructions:
    ~~~bash
    # load dependencies
    source load_modules.sh
    # clone sumo repository
    git clone --recursive https://github.com/eclipse-sumo/sumo
    # install sumo
    cd sumo
    export SUMO_HOME="$PWD"
    cmake -D FOX_INCLUDE_DIR=/cluster/apps/nss/gcc-8.2.0/fox/1.6.57/x86_64/include/fox-1.6 -B build .
    cmake --build build -j$(nproc)
    export PYTHONPATH=$SUMO_HOME/tools:$PYTHONPATH
    ~~~
    So that sumo works everytime you sign into Euler, we suggest adding the follwing to your `~/.bashrc`
    ~~~bash
    export SUMO_HOME=<path-to-sumo-repo>
    export PYTHONPATH=$SUMO_HOME/tools:$PYTHONPATH
    ~~~

    2. Others
    - Please follow instructions [here](https://sumo.dlr.de/docs/Installing/index.html) 
    - Make sure to update `SUMO_HOME` and `PYTHONPATH`. On mac, this can be done by
    appending to your `~/.bashrc`/`~/.zshrc` the following:
    ~~~bash
    export SUMO_HOME=/usr/local/opt/sumo/share/sumo
    export PYTHONPATH=$SUMO_HOME/tools:$PYTHONPATH
    ~~~
    Then, run
    ~~~bash
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
0. Make sure environment and modules are loaded
~~~bash
source load_modules.sh
source venv/bin/activate
~~~

1. Create directory for experiment
~~~bash
mkdir -p ./experiments/atsc_grid1
~~~

2. (For Euler User) Start a session with GPU access
~~~bash
srun -n 4 --mem-per-cpu=4000 --gpus=1 --pty bash
~~~

3. Run experiment
~~~bash
python3 main.py --base-dir experiments/atsc_grid1 train --config-dir config/config_ia2c_grid.ini
~~~

4. (optional) View training progress on Tensorboard
~~~bash
tensorboard --logdir=experiments/atsc_grid1/log
~~~
You can find the dashboard at http://localhost:6006/ 
