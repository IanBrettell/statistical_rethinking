####################
# RStudio Server on Codon
####################

# Build container
bsub -M 20000 -Is bash
cd /hps/software/users/birney/ian/repos/statistical_rethinking
CONT=/hps/nobackup/birney/users/ian/containers/statistical_rethinking/rocker_tidyverse_4.1.0.sif
module load singularity-3.7.0-gcc-9.3.0-dp5ffrp
singularity build --remote \
    $CONT \
    envs/RStudio_Server/rocker_tidyverse_4.1.0.def

# Run container
ssh proxy-codon
bsub -M 20000 -Is bash
module load singularity-3.7.0-gcc-9.3.0-dp5ffrp
CONT=/hps/nobackup/birney/users/ian/containers/statistical_rethinking/rocker_tidyverse_4.1.0.sif
singularity shell --bind /hps/software/users/birney/ian/rstudio_db:/var/lib/rstudio-server \
                  --bind /hps/software/users/birney/ian/tmp:/tmp \
                  --bind /hps/software/users/birney/ian/run:/run \
                  $CONT

# Then run rserver, setting path of config file containing library path
rserver --rsession-config-file /hps/software/users/birney/ian/repos/statistical_rethinking/envs/RStudio_Server/rsession.conf

ssh -L 8787:hl-codon-37-04:8787 proxy-codon


