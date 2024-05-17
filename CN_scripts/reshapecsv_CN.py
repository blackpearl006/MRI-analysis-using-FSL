import pandas as pd
import numpy as np
import os
networks = {
    'CB': 18,
    'CO':32,
    'DMN':34,
    'FP':21,
    'OP': 22,
    'SM':33
}
for net,roi in networks.items():
    path = f'/gpfs/data/user/ninad/ADNI/RAWtime/CN/{net}'
    if os.path.exists(path):
        final_path= f'/gpfs/data/user/ninad/ADNI/FMRtimeseries/CN/{net}'
        os.makedirs(final_path,exist_ok=True)
        for csv_path in os.listdir(path=path):
            print(csv_path)
            try:
                df = pd.read_csv(os.path.join(path,csv_path), header=None)
                data = np.reshape(df.to_numpy(), (roi, -1))
                new_df = pd.DataFrame(data)
                new_df.to_csv(f"{final_path}/sub_{csv_path[:-4]}.csv", header=False,index=False)
            except:
                print('Missing', csv_path)