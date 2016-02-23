should contain csv files that provide necessary concordances eg to a definitve list of sectors or other categories to be used throughout the report.

EXPLANATION OF FILES
country_lookup.csv 
List of original country names to display country names

country_mapping.rda 
Exhaustive list of original country names (created from current data set) that map to display country names

product_codes.csv
Two column data frame that lists a specific product such as "Salmon" with its associated HS10 codes. This tabular struture is converted to a named list inside the program but is serialised as a tabular structure. This list originally obtained from Andrew McCallum.
