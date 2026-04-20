# CHE882_RFD3_RIXI
RFDiffusion3 on RIXI Protein for Mutations
# RFdiffusion3 on RIXI: Attempted Mutation Workflow

This repository documents the attempted workflow used to apply **RFdiffusion3** to the **RIXI protein** for targeted mutation and design exploration. It is written as a reproducible GitHub-style project summary so the sequence setup, region selection, job scripts, and downstream expectations are all captured in one place.

The purpose of this workflow was to:
1. Start from the RIXI wild type protein
2. Focus mutation/design around a selected residue region
3. Generate new RIXI sequence or structure variants using RFdiffusion3
4. Collect the designed outputs for later scoring and comparison with downstream tools such as AlphaFold3 or Boltz2

This repo is mainly a clean summary of the design attempt and a reusable starting point for future RIXI redesign work.

---

## Project goal

The main goal was to generate **RIXI variants** that could potentially improve binding behavior or change interface properties in a controlled region of the protein.

The intended design logic was:

- begin from a known RIXI sequence or structure
- identify a target region of interest
- constrain mutations to a small local window rather than redesigning the full protein
- generate multiple candidate outputs
- pass those candidates into downstream prediction or scoring models
- compare wild type and mutant designs

In this project, the region of interest was centered around the **144 to 153 residue region** of RIXI, which was treated as a likely binding or interaction-relevant area.

---

## What this repository contains

```text
rfdiffusion3-rixi-attempt/
├── README.md
├── .gitignore
├── scripts/
│   ├── submit_rfdiffusion3_rixi.slurm
│   ├── run_rfdiffusion3_rixi.sh
│   ├── prepare_rixi_inputs.py
│   └── summarize_rfdiffusion3_outputs.py
└── examples/
    ├── rixi_wt.fasta
    ├── rixi_design_region.txt
    └── expected_output_notes.txtImportant note

This repository is a documented reconstruction of the RFdiffusion3 workflow attempt. It is not presented as a guaranteed plug-and-play install because the exact local setup, checkpoint paths, and cluster-specific launch commands can vary substantially.

So this repo should be understood as:

a clean project summary
a reusable job template
a record of how RIXI redesign was approached
a bridge to downstream analysis workflows
RIXI starting sequence

The wild type RIXI sequence used in this work was:

AGKTGQMTVFWGRNKNEGTLKETCDTGLYTTVVISFYSVFGHGRYWGDLSGHDLRVIGADIKHCQSKNIFVFLSIGGAGKDYSLPTSKSAADVADNIWNAHMDGRRPGVFRPFGDAAVDGIDFFIDQGAPDHYDDLARNLYAYNKMYRARTPVRLTATVRCAFPDPRMKKALDTKLFERIHVRFYDDATCSYNHAGLAGVMAQWNKWTARYPGSHV
Design target region

The design effort focused on the local sequence region:

Residues 144 to 153

This region was treated as a practical mutation window because it was suspected to matter for RIXI binding or surface interactions.

The broader design philosophy was:

keep most of the RIXI scaffold unchanged
introduce only a small number of mutations
generate several plausible variants rather than one fully redesigned protein
Intended workflow

The intended RFdiffusion3 workflow was:

prepare the wild type RIXI input
define the designable region
run RFdiffusion3 to generate multiple candidate structures
save outputs as designed models
compare and rank outputs in downstream tools

This was not meant to be a fully unconstrained generative design. The goal was a focused mutation campaign.

Expected environment on HPCC

The scripts assume a Linux cluster environment with:

Slurm scheduler
GPU access if required by the selected RFdiffusion3 workflow
Python available through a module or environment
RFdiffusion3 source checked out locally
model checkpoints downloaded
optional container support depending on local installation method

Because RFdiffusion3 setup differs by environment, you may need to edit:

repository path
checkpoint path
inference script path
conda or module activation lines
output directories
number of generated designs
Basic usage
Step 1. Prepare input files

Example:

python scripts/prepare_rixi_inputs.py

This writes:

a FASTA file for wild type RIXI
a text file recording the target design region
Step 2. Edit the Slurm script

Open:

scripts/submit_rfdiffusion3_rixi.slurm

Update:

RFDIFF_REPO
RFDIFF_CKPT
INPUT_FASTA
OUTPUT_DIR

These values must match your actual HPCC directories.

Step 3. Submit the job
sbatch scripts/submit_rfdiffusion3_rixi.slurm
Step 4. Review outputs

If the run succeeds, summarize generated files with:

python scripts/summarize_rfdiffusion3_outputs.py /path/to/output_dir

This script scans the output directory and lists generated CIF, PDB, and JSON-style files.

Why RFdiffusion3 was useful for RIXI

RFdiffusion3 was attractive for this project because it could help generate structural variants rather than only score them. That made it useful earlier in the workflow than AlphaFold3 or Boltz2.

For RIXI, the design value was:

explore local mutations around a chosen site
generate multiple candidate variants
preserve much of the original protein framework
create inputs for later ranking and binding comparison
Practical limitations

The main limitations were not necessarily about the biological idea. They were mostly technical and workflow-related:

1. Exact launch details vary a lot

RFdiffusion3 setups often differ across clusters and repositories. Small differences in environment activation, checkpoints, or inference commands can break a run.

2. Constrained mutation workflows require careful setup

It is easier to generate designs broadly than to tightly control exactly where and how mutations occur. The more constrained the design task, the more carefully the input specification must be built.

3. Output generation is only the first step

Even if RFdiffusion3 produces many candidate structures, those outputs still need downstream ranking. The generated structures alone do not prove improved binding.

4. Best designs still need confidence scoring or docking-style comparison

A successful RFdiffusion3 run creates candidates. It does not automatically determine which candidate is best. That is why later scoring with AlphaFold3, Boltz2, or another evaluation model remained important.

Recommended downstream workflow

A practical next-step workflow after RFdiffusion3 is:

generate a panel of RIXI variants
organize each output by mutation identity
run each design through a scoring model
rank the outputs
visualize mutation patterns and scores with a table or heat map

This makes RFdiffusion3 the design stage rather than the final decision stage.

Summary

This repository documents the RFdiffusion3 mutation attempt for RIXI as a reproducible GitHub-style record. The purpose was to generate targeted RIXI variants around a selected residue window, not to redesign the whole protein from scratch. The overall approach was biologically reasonable and computationally useful, but success depended heavily on environment setup, checkpoint management, and downstream scoring.
