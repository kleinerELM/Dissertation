import numpy as np
import pandas as pd
import os
import glob

# Get directory of the script
dir_path = os.path.dirname(os.path.realpath(__file__))

# Create 'reduced' subdirectory if it doesn't exist
os.makedirs(os.path.join(dir_path, 'reduced', 'zoom'), exist_ok=True)

# Find all freeze_segment CSV files
pattern = os.path.join(dir_path, '*freeze_segment*.csv')
files = glob.glob(pattern)

for path in files:
    filename_base = os.path.basename(path).split('.')[0]
    print(f"Processing {filename_base}")
    
    # Read CSV
    df = pd.read_csv(path)
    
    # Extract pore radii
    radii = df['pore radius in nm'].values
    
    # Calculate reduced indices
    selected_indices = []
    i = 0
    while i < len(radii):
        # step = max(1, int((60 - r) // 6) + 1)
        r = radii[i]
        if r > 24:
            step = 1
        elif r > 18:
            step = 3
        elif r > 12:
            step = 6
        elif r > 6:
            step = 9
        else:
            step = 12
        selected_indices.append(i)
        i += step
    
    # Ensure last value is included
    if (len(radii)-1) not in selected_indices:
        selected_indices.append(len(radii)-1)
    
    # Create reduced dataframe and save
    df_reduced = df.iloc[selected_indices]
    output_path = os.path.join(dir_path, 'reduced', f'{filename_base}.csv')
    df_reduced.to_csv(output_path, index=False)
    print(f"Reduced from {len(radii)} to {len(df_reduced)} values")
    print(f"Saved as {output_path}\n")
    
    filtered = df[(df['pore radius in nm'] >= 1.74) & (df['pore radius in nm'] <= 2.76)]
    df_reduced2 = filtered.iloc[::6]
    output_path = os.path.join(dir_path, 'reduced', 'zoom', f'{filename_base}.csv')
    df_reduced2.to_csv(output_path, index=False)
