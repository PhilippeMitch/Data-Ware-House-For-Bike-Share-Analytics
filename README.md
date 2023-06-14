# README Template

Below is a template provided for use when building your README file for students.

# Data Ware House For Bike Share Analytics

Divvy is a bike sharing program in Chicago, Illinois USA that allows riders to purchase a pass at a kiosk or use a mobile application to unlock a bike at stations around the city and use the bike for a specified amount of time. The bikes can be returned to the same station or to another station. The City of Chicago makes the anonymized bike trip data publicly available for projects like this where we can analyze the data.

Since the data from Divvy are anonymous, we have created fake rider and account profiles along with fake payment data to go along with the data from Divvy. The dataset looks like this:
![](https://github.com/PhilippeMitch/Data-Ware-House-For-Bike-Share-Analytics/blob/main/images/divvy-erd.png)

Relational ERD for the Divvy Bikeshare Dataset (with fake data tables)

## Project Environment
In order to complete this project, you'll need to use these tools:

* Access to Microsoft Azure.
* Python to run the script to load data into a PostgreSQL database on Azure to simulate your OLTP data source
* An editor to work with the Python and SQL scripts, we recommend Visual Studio Code

## Local Machine Instructions

To work locally on this project, you'll need clone this repository into your local machine.
Make sure you have Python and Visual Studio Code installed, or another editor of your choice to run Python scripts. You will also need the [dataset](https://video.udacity-data.com/topher/2022/March/622a5fc6_azure-data-warehouse-projectdatafiles/azure-data-warehouse-projectdatafiles.zip)

### Dependencies
Since we are using a PostgreSQL database you will need to install psycopg2 which is a Python-PostgreSQL Database Adapter.
```sh
pip install psycopg2
```

## Create your Azure resources
* Create an Azure Database for PostgreSQL.
* Create an Azure Synapse workspace. Note that if you've previously created a Synapse Workspace, you do not need to create a second one specifically for the project.
* Use the built-in serverless SQL pool and database within the Synapse workspace

## Create the data in PostgreSQL
* Open the [ProjectDataToPostgres.py](https://github.com/PhilippeMitch/Data-Ware-House-For-Bike-Share-Analytics/blob/main/starter/ProjectDataToPostgres.py) script file in VS Code and add the host, username, and password information for your PostgreSQL database.
* Run the script and verify that all four data files are copied/uploaded into PostgreSQL
You can verify this data exists by using pgAdmin or a similar PostgreSQL data tool.

## EXTRACT the data from PostgreSQL
In your Azure Synapse workspace, use the ingest wizard to create a one-time pipeline that ingests the data from PostgreSQL into Azure Blob Storage. 

![](https://github.com/PhilippeMitch/Data-Ware-House-For-Bike-Share-Analytics/blob/main/images/EXTRACT%20the%20data%20from%20PostgreSQL%20-1.jpg)

This will result in all four tables being represented as text files in Blob Storage, ready for loading into the data warehouse.

![](https://github.com/PhilippeMitch/Data-Ware-House-For-Bike-Share-Analytics/blob/main/images/EXTRACT%20the%20data%20from%20PostgreSQL%20-4.jpg)

## LOAD the data into external tables in the data warehouse
Use the script-generating function from the data lake node to load the data from blob storage into external staging tables in the data warehouse that have been created using the serverless SQL Pool.

![]()
