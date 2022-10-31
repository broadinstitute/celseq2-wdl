FROM continuumio/miniconda3:latest

USER root 
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -yq --no-install-recommends build-essential libhdf5-dev git \
    && apt-get clean

# Create the environment:
RUN conda update -n base -c defaults conda
RUN conda install mamba -c conda-forge
COPY environment.yml .
RUN mamba env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

RUN git clone https://github.com/yanailab/celseq2.git
RUN cd celseq2 && pip install .

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -yq --no-install-recommends bowtie2 \
    && apt-get clean
