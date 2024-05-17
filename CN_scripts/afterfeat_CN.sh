#!/bin/bash
base_dir="/gpfs/data/user/ninad/ADNI/CNStandard_name"
for subject_dir in "$base_dir"/*.feat; do
    if [[ -d "$subject_dir" ]]; then
        subject_name=$(basename "$subject_dir")
        echo $subject_name
        cd "$base_dir/$subject_name"
        fast -t 1 -n 3 -H 0.1 -I 4 -l 20.0 -o reg/highres2standard reg/highres2standard.nii.gz
        convert_xfm -omat reg/invfunc2standard.mat -inverse reg/example_func2standard.mat
        flirt -in reg/highres2standard_pve_0.nii.gz -ref filtered_func_data.nii.gz -applyxfm -init reg/invfunc2standard.mat -out reg/highres2standard_csf_reg.nii.gz
        flirt -in reg/highres2standard_pve_2.nii.gz -ref filtered_func_data.nii.gz -applyxfm -init reg/invfunc2standard.mat -out reg/highres2standard_wm_reg.nii.gz
        fslmaths reg/highres2standard_csf_reg.nii.gz -thr 0.95 reg/csf_mask_95.nii.gz
        fslmaths reg/highres2standard_wm_reg.nii.gz -thr 0.95 reg/wm_mask_95.nii.gz
        fslmeants -i filtered_func_data.nii.gz -o csf_with_noise.txt -m reg/csf_mask_95.nii.gz 
        fslmeants -i filtered_func_data.nii.gz -o wm_with_noise.txt -m reg/wm_mask_95.nii.gz 
        paste csf_with_noise.txt wm_with_noise.txt mc/prefiltered_func_data_mcf.par |tr -d "\t" > paraorig.txt 
        Text2Vest paraorig.txt paraorig.mat
        fsl_glm -i filtered_func_data.nii.gz -d paraorig.mat --out_res=res_brain.nii.gz
        flirt -in res_brain.nii.gz -ref reg/standard.nii.gz -applyxfm -init reg/example_func2standard.mat -out res_brain_std.nii.gz
        fslmaths reg/standard.nii.gz -mul 0 -Tmin -bin roi_template.nii.gz
    fi
done