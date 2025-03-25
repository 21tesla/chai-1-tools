import sys
import logging
import shutil
from pathlib import Path

import numpy as np

from chai_lab.chai1 import run_inference


fasta_path = Path(sys.argv[1])

output_dir = Path(sys.argv[2])
if output_dir.exists():
    logging.warning(f"Removing old output directory: {output_dir}")
    shutil.rmtree(output_dir)
output_dir.mkdir(exist_ok=True)


candidates = run_inference(
    fasta_file=fasta_path,
    output_dir=output_dir,
    num_trunk_recycles=3,
    num_diffn_timesteps=200,
    num_diffn_samples=1,
    seed=42,
    device="cuda:0",
    use_esm_embeddings=True,
)

cif_paths = candidates.cif_paths
agg_scores = [rd.aggregate_score.item() for rd in candidates.ranking_data]


scores = np.load(output_dir.joinpath("scores.model_idx_0.npz"))
periptm = scores['per_chain_pair_iptm'][..., 0, 1].item()
iptm = scores['iptm']
text_scores = output_dir.joinpath("scores.model_idx_0.txt")

f = open(text_scores, "w")

print (fasta_path.stem , " ", periptm, file=f)
f.close
