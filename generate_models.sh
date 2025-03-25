#!/bin/bash
source /home/nmrbox/ldonaldson/miniconda3/etc/profile.d/conda.sh
conda init

# RFdiffusion   

conda activate SE3nvm63

/home/nmrbox/ldonaldson/m6/RFdiffusion/scripts/run_inference.py \
    inference.output_prefix=/home/nmrbox/ldonaldson/RFdiffusion/outputs/ank_7_rf/ank7 \
    inference.input_pdb=/home/nmrbox/ldonaldson/RFdiffusion/examples/input_pdbs/ank.pdb \
    'contigmap.contigs=[A1-292/0 80-110]'\
    'ppi.hotspot_res=[A60,A68,A93,A98,A101,A134,A138]' \
    inference.num_designs=1000 denoiser.noise_scale_ca=0 denoiser.noise_scale_frame=0 

conda deactivate 

# Protein_MPNN 

conda activate dl_binder_design

/home/nmrbox/ldonaldson/dl_binder_design/mpnn_fr/dl_interface_design.py \
                         -pdbdir /home/nmrbox/ldonaldson/RFdiffusion/outputs/ank_7_rf \
                         -outpdbdir /home/nmrbox/ldonaldson/RFdiffusion/outputs/ank_7_mpnn \
                         -relax_cycles 0     \
                         -seqs_per_struct 2  

rm check.point 2>/dev/null

conda deactivate

# Chai-1 folding

#conda activate chai

#cd /home/nmrbox/ldonaldson/RFdiffusion/output
#./send-to-chai-0.sh ank_7_mpnn

