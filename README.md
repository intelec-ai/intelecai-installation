# Intelec AI - Automated machine learning platform with GPU support free to download

This repository is intended to help people install and configure Intelec AI. Please note that Intelec AI works on [Docker](https://www.docker.com/). Please download and install docker before starting Intelec AI installation.

## About Intelec AI

Intelec AI is a platform to automate building and deploying machine learning models. 

[![Intelec AI Demo](https://github.com/intelec-ai/intelecai-installation/raw/master/img/demo_image.png)](https://www.youtube.com/watch?v=klv_3L68MJ0)

## Installation in Windows

0. Download, install and start docker in your machine, if you haven't done it so far. You can install Docker Desktop for Windows following this link https://docs.docker.com/docker-for-windows/install/ and clicking on "Download from Docker Hub". 
1. Download the required files for Intelec AI installaton from Github. You can do it either of the following 2 ways:
   * download them as a zip file from here https://github.com/intelec-ai/intelecai-installation/archive/master.zip and unzip it (right click on the zip file and choose "Extract All...")
   * or clone the git repository like this `git clone https://github.com/intelec-ai/intelecai-installation.git`
2. Go to the downloaded folder, click on `setup_for_windows.bat` and follow the instructions.
3. You can start Intelec AI by clicking on `start_servers.bat` after the set up is complete.
4. Wait for 10 seconds, then visit http://localhost:7700 to open Intelec AI.
5. You can stop Intelec AI by clicking on `stop_servers.bat`.

## Installation in Linux and Mac

0. Download, install and start docker in your machine, if you haven't done it so far. You can [install Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/install/) or [Docker Community Edition for Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/) (choose the appropriate linux distribution from the left hand side).
1. Download the required files for Intelec AI installaton from Github. You can do it either of the following 2 ways:
   * download them as a zip file from here https://github.com/intelec-ai/intelecai-installation/archive/master.zip and unzip it. For example,
      * `wget https://github.com/intelec-ai/intelecai-installation/archive/master.zip`
      * `unzip intelecai-installation-master.zip`
   * or clone the git repository like this `git clone https://github.com/intelec-ai/intelecai-installation.git`
2. Go to the downloaded folder and give 'executable' permission to the required files: 
   * `cd intelecai-installation`
   * `chmod +x *.sh`
3. Run `setup_for_linux_mac.sh` and follow the instructions. You can set up Intelec AI in 2 different ways in linux:
   * for normal set up, please run `./setup_for_linux_mac.sh` 
   * for set up with **GPU support**, please run `./setup_for_linux_mac.sh --gpu` . Note that you need to install [Nvidia Docker](https://github.com/NVIDIA/nvidia-docker) if you would like to set up Intelec AI with GPU support.
3. You can start Intelec AI by running `start_servers.sh` after the set up is complete.
4. Wait for 10 seconds, then visit http://localhost:7700 to open Intelec AI.
5. You can stop Intelec AI by running `stop_servers.sh`.

## Installation demo

The following demo shows how to install Intelec AI in a computer step-by-step.

[![Intelec AI installation demo](https://github.com/intelec-ai/intelecai-installation/raw/master/img/installation_demo.png)](https://www.youtube.com/watch?v=0fQquKIb1MU)

## Report a problem or give a feedback

Please write to [info@intelec.ai](mailto://info@intelec.ai) or fill [this form](https://forms.gle/tcWBTaGUnJJGpJVd8) to report a problem or give a feedback.