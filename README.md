# Population_Migration_Network
This repository contains all the steps to produce the paper "Who converges with whom? Global migration network and the geography of development". It uses python to prepare the dataset and to plot the lines, R studio to visualize and Stata for panel data analysis. The folder `01_preparing` contains notebook, rmd and do file. Raw subfolder of the data folder contains all the raw data, except the annual bilateral migration data which is more than 2GB. Reproduction of the data cleaning proceess requires downloading the csv file `migration_imputed_RIKS_dec2021.csv` from the following link and storing it in the raw subfolder,
https://data.mendeley.com/datasets/cpt3nh6jct/1


The following mermaid plot illustrates the data journey,



```mermaid
flowchart TD
    A((Start)) --> B[01_preparing]
    B -->|Uses data from| C[(data/raw)]
    B -->|Saves cleaned data to| D[(data/cleaned)]
    D --> |Uses data to conduct analysis| B[01_preparing]
    B -->|saves plots|E[outputs]
