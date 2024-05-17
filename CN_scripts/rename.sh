#!/bin/bash

base_dir="path/CNnifti"
out_dir="path/CNStandard_name"
for subject_dir in "$base_dir"/*; do
    if [[ -d "$subject_dir" ]]; then
        for subject_modality in "$subject_dir"/*; do
            if [[ -d "$subject_modality" ]]; then
                for subject_visit in "$subject_modality"/*; do
                    if [[ -d "$subject_visit" ]]; then
                        visit_date=$(basename "$subject_visit")
                        subject_name=$(basename "$subject_dir")
                        nifti_files=("$subject_visit"/*.nii.gz)
                        for nifti_file in "${nifti_files[@]}"; do
                            nifti_filename=$(basename "$nifti_file" .nii.gz)
                            if [[ $nifti_filename == *"resting"* ]]; then
                                newdirname=${subject_name}_${visit_date:0:10}
                                mkdir -p "$out_dir/$newdirname"
                                trimmed_filename="${newdirname}_f"
                                cp "$nifti_file" "$out_dir/$newdirname/$trimmed_filename.nii.gz"
                            fi
                        done
                    fi
                done
            fi
        done
    fi
done    
