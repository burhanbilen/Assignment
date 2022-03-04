###  Task: Implement code to list the top-3 countries with highest median daily vaccination numbers by considering missing values imputed version of dataset.

import pandas as pd
import numpy as np

df = pd.read_csv("country_vaccination_stats.csv", delimiter=",") # Read and separate column values with comma

df['daily_vaccinations'].replace(np.nan, 0.0, inplace=True) # Replace nan values of the specific column with 0

top_three = df.groupby('country')['daily_vaccinations'].median().sort_values()[::-1][:3] # Group countries by daily vaccinations by their medians, then sort values and then reverse output to get first three(top) values.
print(top_three)
