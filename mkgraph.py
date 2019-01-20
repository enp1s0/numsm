import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import os
plt.figure(figsize=(16, 9))
#plt.rcParams['font.family'] = 'Ricty'
#plt.rcParams['font.family'] = 'Meiryo'
plt.rcParams["font.size"] = 22
plt.rcParams["xtick.labelsize"] = 12
plt.rcParams["ytick.labelsize"] = 15
plt.rcParams["legend.fontsize"] = 18
plt.grid()
plt.xlabel("clock")
plt.ylabel("tid")

df = pd.read_csv("clock.csv", encoding="UTF-8")
tid_list = df["tid"]

min_start_clock = min(df["start"])
start_clock_list = [x - min_start_clock for x in df["start"]]
end_clock_list = [x - min_start_clock for x in df["end"]]

for i in range(len(tid_list)):
    y = .5 + i
    start_x = start_clock_list[i]
    end_x = end_clock_list[i]
    plt.plot([start_x, end_x], [y, y], lw=1)

plt.savefig("clock.svg");
