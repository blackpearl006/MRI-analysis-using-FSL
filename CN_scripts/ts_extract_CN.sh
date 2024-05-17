#!/bin/bash
base_dir="/gpfs/data/user/ninad/ADNI/CNStandard_name"
for i in CB DMN FP OP CO SM; do
    file_path="/gpfs/data/user/ninad/DoschenbachROI/$i.txt"
    for subject_dir in "$base_dir"/*.feat; do
        if [[ -d "$subject_dir" ]]; then
            subject_name=$(basename "$subject_dir")
            echo $subject_name
            cd "$base_dir/$subject_name"
            subject_name1=$(basename "$subject_dir" .feat)
            output_file="${subject_name1}_${i}.csv"
            counter=0
            while read line; do
                IFS=',' read -r centerx centery centerz <<< "$line"	
                counter=$((counter+1))
                fslmaths roi_template.nii.gz -mul 0 -add 1 -roi $centerx 1 $centery 1 $centerz 1 0 1 ACCpoint -odt float
                fslmaths ACCpoint -kernel sphere 5 -fmean ACCsphere_$counter -odt float
                fslmaths ACCsphere_$counter.nii.gz -bin ACCsphere_bin_$counter.nii.gz
                roi_timeseries=$(fslmeants -i res_brain_std -m ACCsphere_bin_$counter)
                time_series="$roi_timeseries"
                echo "$time_series" >> $output_file
            done < $file_path
            rm -r ACC*
        fi
    done
done