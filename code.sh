#!/bin/bash
#SBATCH --job-name=rfdiff_rixi
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH --output=slurm-%j.out

set -euo pipefail

# ==========================
# USER-EDITABLE PATHS
# ==========================
RFDIFF_REPO="/path/to/RFdiffusion3"
RFDIFF_CKPT="/path/to/rfdiffusion3_checkpoint.pt"
INPUT_FASTA="/path/to/rfdiffusion3-rixi-attempt/examples/rixi_wt.fasta"
OUTPUT_DIR="/path/to/rfdiffusion3_outputs/rixi_designs"

# Optional controls
NUM_DESIGNS=50
DESIGN_REGION="144-153"

# ==========================
# ENVIRONMENT SETUP
# ==========================
module purge
module load Python/3.10.4
# module load CUDA/appropriate-version

mkdir -p "${OUTPUT_DIR}"

echo "Starting RFdiffusion3 RIXI job"
echo "Repo:        ${RFDIFF_REPO}"
echo "Checkpoint:  ${RFDIFF_CKPT}"
echo "Input FASTA: ${INPUT_FASTA}"
echo "Output dir:  ${OUTPUT_DIR}"
echo "Design site: ${DESIGN_REGION}"
echo "Num designs: ${NUM_DESIGNS}"

bash "${RFDIFF_REPO}/run_rfdiffusion3_rixi.sh" \
    "${RFDIFF_REPO}" \
    "${RFDIFF_CKPT}" \
    "${INPUT_FASTA}" \
    "${OUTPUT_DIR}" \
    "${DESIGN_REGION}" \
    "${NUM_DESIGNS}"

echo "Job completed"#!/bin/bash
set -euo pipefail

RFDIFF_REPO="$1"
RFDIFF_CKPT="$2"
INPUT_FASTA="$3"
OUTPUT_DIR="$4"
DESIGN_REGION="$5"
NUM_DESIGNS="$6"

cd "${RFDIFF_REPO}"

echo "Running RFdiffusion3 wrapper..."
echo "Repository: ${RFDIFF_REPO}"
echo "Checkpoint: ${RFDIFF_CKPT}"
echo "Input FASTA: ${INPUT_FASTA}"
echo "Output dir: ${OUTPUT_DIR}"
echo "Design region: ${DESIGN_REGION}"
echo "Number of designs: ${NUM_DESIGNS}"

# ------------------------------------------------------------------
# EXAMPLE PLACEHOLDER COMMAND
# ------------------------------------------------------------------
# Replace this block with the exact command required by your install.
#
# The real command may involve:
#   - a Python inference script
#   - Hydra config arguments
#   - contig or mask specifications
#   - checkpoint flags
#   - output prefix settings
#
# Example pseudo-command:
#
# python scripts/run_inference.py \
#   inference.input_fasta="${INPUT_FASTA}" \
#   inference.output_prefix="${OUTPUT_DIR}/rixi" \
#   inference.num_designs="${NUM_DESIGNS}" \
#   inference.ckpt_path="${RFDIFF_CKPT}"
#
# If your constrained design requires a more specific mask or region
# definition, insert that logic here using your exact RFdiffusion3 syntax.
# ------------------------------------------------------------------

echo "No exact RFdiffusion3 command was inserted because the original"
echo "attempt did not stabilize to one confirmed working cluster command."
echo "Edit this script with the final command for your environment."from pathlib import Path

rixi_sequence = (
    "AGKTGQMTVFWGRNKNEGTLKETCDTGLYTTVVISFYSVFGHGRYWGDLSGHDLRVIGADIKHCQSKNIF"
    "VFLSIGGAGKDYSLPTSKSAADVADNIWNAHMDGRRPGVFRPFGDAAVDGIDFFIDQGAPDHYDDLARNL"
    "YAYNKMYRARTPVRLTATVRCAFPDPRMKKALDTKLFERIHVRFYDDATCSYNHAGLAGVMAQWNKWTAR"
    "YPGSHV"
)

examples_dir = Path("examples")
examples_dir.mkdir(parents=True, exist_ok=True)

with open(examples_dir / "rixi_wt.fasta", "w") as f:
    f.write(">RIXI_WT\n")
    f.write(rixi_sequence + "\n")

with open(examples_dir / "rixi_design_region.txt", "w") as f:
    f.write("Target design region: residues 144-153\n")
    f.write("Design strategy: preserve most of scaffold, explore local mutations\n")

print("Wrote input files:")
print((examples_dir / "rixi_wt.fasta").resolve())
print((examples_dir / "rixi_design_region.txt").resolve())import sys
from pathlib import Path

def main(output_dir):
    output_dir = Path(output_dir)
    if not output_dir.exists():
        print(f"Directory not found: {output_dir}")
        sys.exit(1)

    exts = {".cif", ".pdb", ".json", ".txt"}
    files = [p for p in output_dir.rglob("*") if p.is_file() and p.suffix.lower() in exts]

    if not files:
        print("No expected output files found.")
        return

    print("generated_file")
    for f in sorted(files):
        print(f)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python scripts/summarize_rfdiffusion3_outputs.py /path/to/output_dir")
        sys.exit(1)
    main(sys.argv[1])>RIXI_WT
AGKTGQMTVFWGRNKNEGTLKETCDTGLYTTVVISFYSVFGHGRYWGDLSGHDLRVIGADIKHCQSKNIFVFLSIGGAGKDYSLPTSKSAADVADNIWNAHMDGRRPGVFRPFGDAAVDGIDFFIDQGAPDHYDDLARNLYAYNKMYRARTPVRLTATVRCAFPDPRMKKALDTKLFERIHVRFYDDATCSYNHAGLAGVMAQWNKWTARYPGSHVTarget design region: residues 144-153
Design strategy: preserve most of scaffold, explore local mutations
