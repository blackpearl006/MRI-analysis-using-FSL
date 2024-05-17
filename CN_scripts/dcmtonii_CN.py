import dicom2nifti
import os

path = '/gpfs/data/user/ninad/ADNI/CN/ADNI'
outpath='/gpfs/data/user/ninad/ADNI/CNnifti'

for subject in os.listdir(os.path.join(path)):
    for modality in os.listdir(os.path.join(path,subject)):
        for visit in os.listdir(os.path.join(path,subject,modality)):
            for someid in os.listdir(os.path.join(path,subject,modality,visit)):
                inpath = os.path.join(path,subject,modality,visit,someid)
                out_path = os.path.join(outpath,subject,modality,visit)
                print(subject)
                if not os.path.exists(out_path):
                    os.makedirs(out_path)
                dicom2nifti.convert_directory(inpath, out_path, compression=True, reorient=True)
                