#!/bin/bash
base_dir="/gpfs/data/user/ninad/ADNI/CNStandard_name"
for i in CB DMN FP OP CO SM; do
    out_path="/gpfs/data/user/ninad/ADNI/RAWtime/CN/$i"
    mkdir -p "$out_path"
    for subject_dir in "$base_dir"/*.feat; do
        if [[ -d "$subject_dir" ]]; then
            subject_name=$(basename "$subject_dir")
            subject_name1=$(basename "$subject_dir" .feat)
            echo "$subject_name"
            cd "$base_dir/$subject_name" || exit 1  
            output_file="${subject_name1}_${i}.csv"
            cp "$output_file" "$out_path"
            subject_name1=$(basename "$subject_dir" .feat)
            new_file_name="$subject_name1.csv"
            mv "${out_path}/${output_file}" "${out_path}/${new_file_name}"
        fi
    done
done