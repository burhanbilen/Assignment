###  Task: Implement code to list the top-3 countries with highest median daily vaccination numbers by considering missing values imputed version of dataset.

import pandas as pd
import numpy as np

df = pd.read_csv("country_vaccination_stats.csv", delimiter=",") # Read and separate columns with comma

null_count = df.isna().sum() # Check the number of missing values for each columns
print(null_count)

country_records = df.country.value_counts() # Count the number of records for each country
groupped_records = df.groupby('country')['daily_vaccinations'] # Group all daily vaccinations by the 'country' column

for record in groupped_records: # Iterate over groupped records   
    if country_records[record[0]] < 2: # if the number of records is just 1, that means no valid records for that country
        df.loc[(df['country'] == record[0]) & (df.daily_vaccinations.isna()), 'daily_vaccinations'] = 0.0
    df.loc[(df['country'] == record[0]) & (df.daily_vaccinations.isna()), 'daily_vaccinations'] = groupped_records.min()[record[0]]

    """ if the country matches the index - in .loc[] section - which is called "record", and if it has nan values,
    change it by the minimum value of the current index(country) """

#df.to_csv("ImputedData.csv", encoding="utf-8", index=False) # Save the new imputed dataset

top_three = df.groupby('country')['daily_vaccinations'].median().sort_values()[::-1][:3] # Group countries by daily vaccinations using their medians, then sort values and then reverse the output to get first three (top) values.
print(top_three)
