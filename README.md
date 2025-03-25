# chai-1-tools
a few scripts to run Chai-1 with RFdiffusion

I put this together very quickly and inelegantly to run Chai-1 instead of AlphaFold2 for validation of RFdiffusion/ProteinMPNN generated complexes. I ran this all on NMRBox with Cuda 12 and an Nvidia L40S GPU. 

My directory structure is 

~/dl_binder_design

~/RFdiffusion

~/Chai-1

Each module has its own conda enviroment. I start the structure generation from within the examples directory of RFdiffusion, letting RFdiffusion generate backbones in the outputs/ director and then the adding amino acids with Protein_MPNN withing dl_binder_design. The overall directory structure therefore is found within RFdiffusion/outputs for protein "example" as 

example_rf  --> RFdiffusion generated backbones

example_mpnn --> Protein_MPNN candidate sequences/coordinates

example_mpnn_chai --> Chai-1 validated structures from the contents of the example_mpnn directory

example_best --> the best structures sorted by Chai ipTM statistics

A shell script in RFdiffusion/examples called "generate_models.sh" will load in the appropriate conda environment, run RFdiffusion, and then run Protein_MPNN. The output directories will be foudn in ~/RFdiffusion/outputs

To run Chai-1 against the structures found in the _mpnn directory, run the shell script "send-to-chai-0.sh". In my actual enviroment, I explicitly tell the script and Chai-1 to run on a specific GPU so I have scripts called "send-to-chai-1.sh" and "send-to-chai-2.sh", respectively. This shell script will extract the sequence from the starting structure with "chaipdb2fasta.pl" and write it out temporarily in the RFdiffusion/output directory as a .fa file. The python script will then use this sequence to call Chai-1, generate a complex, and write out some useful statistics. 

I generally make >10000 RFdiffusion candidates and then write out 2 structure for each with Protein_MPNN. Chai-1 works fast enough to get through 2000+ structures in less than a day. The best structures can be sorted and written out into a new directory with the "get_top10.sh" script.
