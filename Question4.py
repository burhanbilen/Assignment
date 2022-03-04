### Task: Implement code to fill the missing data (impute) in daily_vaccinations column per country with the minimum daily vaccination number of relevant countries.

import pandas as pd
import numpy as np

df = pd.read_csv("country_vaccination_stats.csv", delimiter=",") # Read and separate columns with comma

null_count = df.isna().sum() # Check the number of missing values for each columns
print(null_count)

df['daily_vaccinations'].replace(np.nan, 0.0, inplace=True) # Replace nan values of the specific column with 0
print(df)
