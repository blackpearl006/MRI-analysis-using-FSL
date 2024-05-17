#!/bin/bash
base_dir="/gpfs/data/user/ninad/ADNI/CNStandard_name"
for subject_dir in "$base_dir"/*; do
    if [[ -d "$subject_dir" ]]; then
        subject_name=$(basename "$subject_dir")
        echo "$subject_name"
        cd "$subject_dir"
        if [ -e *sbrain.nii.gz ] && [ -e *f.nii.gz ]; then
            echo "found $subject_name"
            feat design.fsf
        else
            echo "NOT FOUND $subject_name"
        fi
    fi
done