# Intelec AI - Automated machine learning platform with GPU support free to download

This repository is intended to help people set up Intelec AI on their computer or server. Please note that Intelec AI works on [Docker](https://www.docker.com/). Hence, please download and install docker before starting to set up Intelec AI.

## About Intelec AI

Intelec AI is a zero code machine learning platform. It can help you automate building and deploying machine learning models.

[![Intelec AI Demo](https://github.com/intelec-ai/intelecai-installation/raw/master/img/demo_image.png)](https://www.youtube.com/watch?v=7qJ6chU_5UE)

## Setting up Intelec AI in Windows

0. Download, install and start docker in your machine, if you haven't done it so far. You can install Docker Desktop for Windows following this link https://docs.docker.com/docker-for-windows/install/ and clicking on "Download from Docker Hub". 
1. Download the required files for Intelec AI set up from Github. You can do it either of the following 2 ways:
   * download them as a zip file from here https://github.com/intelec-ai/intelecai-installation/archive/master.zip and unzip it (right click on the zip file and choose "Extract All...")
   * or clone the git repository like this `git clone https://github.com/intelec-ai/intelecai-installation.git`
2. (Optional) It would be nice if you could let docker use more memory and CPU. You can do it by going Docker > Settings > Advanced and increasing the limits for CPU, memory and swap. For example,

![Open docker settings](https://github.com/intelec-ai/intelecai-installation/raw/master/img/open_docker_settings.png)

![Increase limits](https://github.com/intelec-ai/intelecai-installation/raw/master/img/increase_limits.png)

3. Start Intelec AI by clicking on `start_servers.bat`.
4. Visit http://localhost:7700 to open Intelec AI.
5. You can stop Intelec AI by clicking on `stop_servers.bat`.

## Installation in Linux and Mac

0. Download, install and start docker in your machine, if you haven't done it so far. You can [install Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/install/) or [Docker Community Edition for Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/) (choose the appropriate linux distribution from the left hand side).
1. In Linux, [Manage docker as a non-root user](https://docs.docker.com/engine/install/linux-postinstall/)
2. Download the required files for Intelec AI set up from Github. You can do it either of the following 2 ways:
   * download them as a zip file from here https://github.com/intelec-ai/intelecai-installation/archive/master.zip and unzip it. For example,
      * `wget https://github.com/intelec-ai/intelecai-installation/archive/master.zip`
      * `unzip intelecai-installation-master.zip`
   * or clone the git repository like this `git clone https://github.com/intelec-ai/intelecai-installation.git`
3. Go to the downloaded folder and give 'executable' permission to the required files: 
   * `cd intelecai-installation`
   * `chmod +x *.sh`
4. Now you can start Intelec AI by running `./start_servers.sh`.
5. Visit http://localhost:7700 to open Intelec AI.
6. You can stop Intelec AI by running `./stop_servers.sh`.

## GPU support

You need to have Linux operating system and an Nvidia GPU in order to add GPU support to your Intelec AI installation. If you have them, please go ahead and install Nvidia drivers and [nvidia-container-toolkit](https://github.com/NVIDIA/nvidia-docker). You will also need to set nvidia as default runtime in `/etc/docker/daemon.json`:

```
{
    "default-runtime":"nvidia",
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
```

## Troubleshooting

If you can't open the web page of Intelec AI, you can use following techniques to find out the problem:

1. If you have an older version of docker, please uninstall it, then install a newer one, hopefully the latest version.

2. Check whether all docker services of Intelec AI are running. "REPLICAS" column should show "1/1" for all services. If one of the services is "0/1", then check the log of that service to find out why: `docker service logs [service ID]`. For example, you will need to run `docker service logs ky0p7rt281be` in the following case:

![Check docker services](https://github.com/intelec-ai/intelecai-installation/raw/master/img/check_docker_services.png)

3. If a failed service has no logs, check why the service can't be started. You can do it by inspecting the corresponding docker task. First, run `docker stack ps intelecai` to find out the task ID. Then execute `docker inspect [taskID]`. For example,

![Inspect task](https://github.com/intelec-ai/intelecai-installation/raw/master/img/inspect_task.png)

## Report a problem or give a feedback

Please write to [info@intelec.ai](mailto://info@intelec.ai) or fill [this form](https://forms.gle/tcWBTaGUnJJGpJVd8) to report a problem or give a feedback.