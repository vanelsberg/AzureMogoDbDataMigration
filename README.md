
# Azure MogoDb Data Migration #

This repository code is about migrating your Nighscout data at Atlas/MongoDb (as used for deployment on Heroku) to Azure Cosmos DB for MongoDB.

## Migrating data ##

The methode used here exporting/importing MongoDb data using the MongoDB client tools. These script a run from a Docker "mongo:4.4" container.

Note that the method described below assumes you have succesfully deployed your Nightcout application on Azure using the exelent tutorial *How to setup the Nightscout Diabetes Management Open Source Server on Azure FOR FREE_ by Scott Hanselman* ([see his Youtube link](#appendix)) which essentially is the same as described on [nightscout.github.io/vendors](#appendix). 

It is recommended to run this from WSL on Windows 10/11 or any linux box supporting Docker and/or mongodb.

You may choose to not use docker: it is possible to run the scripts directly on a linux host with the MongoDB client tools installed. You may need to to slightly alter the script provided fro this,

## The migration proceure in general:

### Edit Settings
Start by editying the _.env_ file to specify your database connection parameters.

### Export/import data
Next start the docker container and migrate the data from Atlas to Azure:

1. Start a mongodb docker container
2. Export relevant MongoDb collections from the Atlas/MongoDB database by running the _mongoexport_ tool on the container.
3. Import data the data exported into the MongoDB databse on Azure running the _mongoimport_ tool on the container
4. Stop the container

Next we need to WAIT some time for the MongoDB to settle down and rebuild indexes on the newly imported data.

1. WAIT for about 15 minutes
2. Restart your Nighscout Azure WebApp
3. Try to open/acess the NS webpage

When the site finaly start it most likely will start requesting for a default profile: IGNORE & WAIT!
Be patient...

1. WAIT for another 10 minutes or so.
2. Try to open/access the NS webpage (it will open but most likely will have no data yet)
3. Close the web page.

## Finalizing
Be patient. The database is busy rebuilding indexes. Depending on the data size of your database this may take some time .

1. WAIT for about 30 minutes.
2. Open the NS web page and check the _Nighscout Admin Tools_ until it does not show errors on reading the database.
3. Use the Admin page to "trim" your database by deleting _devicestatus/treatments/entries_ older then 180 days.

Now let the site run for some time before you start changing settings or uploading data.
Have fun!

## Scripts to run:
Make sure to edit the .env file!:

    1. start_mongo.sh
    2. export_herokudb.sh
    3. restore_from_herokudump.sh
    4. stop_mongo.sh

## Tips:

1. When setting up your Azure site following the tutorial, make sure not the define the _"iob" and "cob" plugins_. This can prevent the site from initial startup.

2. Do not forget to disable public access to your NS site (add setting AUTH_DEFAULT_ROLES=denied)

# APPENDIX #

[Nightscout Web Monitor (a.k.a. cgm-remote-monitor)](https://github.com/nightscout/cgm-remote-monitor)

#### Tutorial on Youtube:
This exellent tutorial by Scott Hanselman shows how to setup your Nighscout site on Azure for Free, step by step:

[How to setup the Nightscout Diabetes Management Open Source Server on Azure FOR FREE](https://youtu.be/EDADrteGBnY)

Note that when you exactly follow de steps Scott explaines in his video blog your Nighscout deployment on Azure will be free of charge, even when the 1 year trial expires!

#### Other:

[nightscout.github.io/vendors: Migrate to Azure](http://nightscout.github.io/vendors/azure/migrate/)

