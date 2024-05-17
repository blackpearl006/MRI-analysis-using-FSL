#!/bin/bash

base_dir="/gpfs/data/user/ninad/ADNI/ADnifti"
out_dir="/gpfs/data/user/ninad/ADNI/ADStandard_name"
for subject_dir in "$base_dir"/*; do
    if [[ -d "$subject_dir" ]]; then
        for subject_modality in "$subject_dir"/*; do
            if [[ -d "$subject_modality" ]]; then
                for subject_visit in "$subject_modality"/*; do
                    if [[ -d "$subject_visit" ]]; then
                        visit_date=$(basename "$subject_visit")
                        subject_name=$(basename "$subject_dir")
                        echo $subject_name
                        nifti_files=("$subject_visit"/*.nii.gz)
                        for nifti_file in "${nifti_files[@]}"; do
                            nifti_filename=$(basename "$nifti_file" .nii.gz)
                            if [[ $nifti_filename == *"mprage"* ]]; then
                                for allfmr in "$out_dir/$subject_name*"; do
                                    for i in $allfmr;do
                                        final_subject_name=$(basename "$i")
                                        trimmed_filename="${final_subject_name}_s"
                                        # echo "$i/$trimmed_filename.nii.gz"
                                        cp "$nifti_file" "$i/$trimmed_filename.nii.gz"
                                    done
                                done
                                break
                            fi
                        done
                    fi
                done
            fi
        done
    fi
done    