#!/bin/bash

#SBATCH --time=11:59:59
#SBATCH --job-name=kge
#SBATCH --ntasks-per-node=1
#SBATCH --partition=short
#SBATCH --gres=gpu:v100:1 --constraint='gpu_mem:32GB'
#SBATCH --mem-per-cpu=32G

module purge
module load Anaconda3
source activate $DATA/myenv


CUDA_VISIBLE_DEVICES=0 python3.9 -u codes/run.py --do_train \
 --cuda \
 --do_test \
 --data_path data/Hetionet_inv \
 --model ComplEx \
 -n 1 -b 128 -d 128 \
 -g 24.0 -a 1.0 -adv \
 -lr 0.0001 --max_steps 150000 \
 -save models/ComplEx_Het_0 --test_batch_size 16 -de -dr
