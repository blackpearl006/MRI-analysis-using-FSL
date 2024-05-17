#!/bin/bash
base_dir="/gpfs/data/user/ninad/ADNI/CNStandard_name"
for subject_dir in "$base_dir"/*; do
    if [[ -d "$subject_dir" ]]; then
        subject_name=$(basename "$subject_dir")
        # echo "$subject_name"
        in_img="$subject_dir/${subject_name}_s.nii.gz"
        robust_img="$subject_dir/${subject_name}_rbrain" 
        out_img="$subject_dir/${subject_name}_sbrain" 
        robustfov -i $in_img -r $robust_img 
        bet2 $robust_img $out_img -f 0.3
    fi
done