import re
import pandas as pd

df = pd.DataFrame([['AXO145', '<url>https://xcd32112.smart_meter.com</url>'], # The given table, transformed to DataFrame
                   ['TRU151', '<url>http://tXh67.dia_meter.com</url>'],
                   ['ZOD231', '<url>http://yT5495.smart_meter.com</url>'],
                   ['YRT326', '<url>https://ret323_TRu.crown.com</url>'],
                   ['LWR245', '<url>https://luwr3243.celcius.com</url>']])

result = list() # Empty list to keep results
for row in df.values: # Iterate over the values of the DataFrame

    """
    With the use of regex, find all the matched items which are between "<url>http://" and "</url>" or (|) between "<url>https://" and "</url>"
    .(dot) means any character can come, and +(plus) means matching at least 1 times or more. Thus, everything between the parenthesis (()) are excluded.
    Since using the OR condition in the regex query, the output len is 2.
    So, to discard the non-matching index, by the use of if condition, name and extracted texts are appended to the list called "result"  
    """
    
    find = re.findall('<url>http://(.+)</url>|<url>https://(.+)</url>', str(row))[0]

    if find[0] != "":
        result.append([row[0], find[0]])
    else:
        result.append([row[0], find[1]])

print(result)
