#!/bin/bash
designfile='/gpfs/data/user/ninad/ADNI/ADStandard_name/design.fsf'
base_dir="/gpfs/data/user/ninad/ADNI/ADStandard_name"
for subject_dir in "$base_dir"/*; do
    if [[ -d "$subject_dir" ]]; then
        subject_name=$(basename "$subject_dir")
        echo "Processing subject: $subject_name"
        # new_designfile="${subject_dir}/${subject_name}.fsf"
        new_designfile="${subject_dir}/design.fsf"
        # echo $new_designfile
        cp "$designfile" "$new_designfile"
        sed -i "s/002_S_2010_2011-01-22/$subject_name/g" "$new_designfile"
        sed -i "s/002_S_2010_2011-01-22_f/${subject_name}_f/g" "$new_designfile"
        sed -i "s/002_S_2010_2011-01-22_sbrain/${subject_name}_sbrain/g" "$new_designfile"
        echo "Design file copied and modified for $subject_name"
    fi
done
