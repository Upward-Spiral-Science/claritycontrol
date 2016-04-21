import numpy as np

FEATURES_PATH = '../data/roi_features/'
cocaines = ['cocaine173_rois.csv','cocaine174_rois.csv','cocaine175_rois.csv','cocaine177_rois.csv','cocaine178_rois.csv']
controls = ['control181_rois.csv','control182_rois.csv','control189_rois.csv','control239_rois.csv','control258_rois.csv']
fears = ['fear187_rois.csv','fear188_rois.csv','fear197_rois.csv','fear199_rois.csv','fear200_rois.csv']

# label, number, roi, x, y, z, mean, std, [1-12] features  # 20
features = np.zeros(20, dtype=np.float32)

roi_pos = np.genfromtxt(FEATURES_PATH+'roi_pos.csv', delimiter=",", dtype=np.float32)

for fname in cocaines+controls+fears:
    label = fname[:-12]
    if label == 'cocaine':
        label = 0
    elif label == 'control':
        label = 1
    elif label == 'fear':
        label = 2

    number = fname[-12:-9]
    data = np.genfromtxt(FEATURES_PATH+fname, delimiter=",", dtype=np.float32)
    nrow, ncol = data.shape
    for i in range(0, nrow):
        result = np.zeros(20, dtype=np.float32)
        row = data[i, :]
        result[-12:] = np.mean(np.reshape(row[:-3], (13, 12)), axis=0)
        result[0] = label
        result[1] = int(fname[-12:-9])
        result[2] = row[-1]
        result[3:6] = roi_pos[i, 1:4]
        result[6:8] = row[-3:-1]
        features = np.vstack((features, result))

features = features[1:, :]
np.savetxt(FEATURES_PATH+'features.csv', features, fmt='%10.5f', delimiter=',')




