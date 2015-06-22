# PostGIS Analysis (with Docker)
With this Docker Orcherster you can perform geospatial analysis with PostGIS withput cluttering your dev maschine.
The PostGIS Database will be persited unless you rebuild the app.
The data directory is persisted too unless you again rebuild the app or the data container.

## Setup
Move your data into the data directory. Every file will be copied into the /data directory
Run the app with `docker-compose run app bash`

### CSV to PostGIS
```shell
csvsql --db postgres://docker:docker@db/gis --insert your.csv
```
### SHP to PostGIS
Create a SQL file to insert the content of your shapefile in the table with `tablename`
```shell
shp2pgsql -s 4326 your.shp tablename > your.sql
```
Insert the SQL file into PostGIS
```shell
psql -h db -U docker -p 5432 -d gis -f your.sql
```

### Connect to yxou PostGIS DB
You can connect to you PostGIS DB and perform any kind of querys:
```shell
psql -h db -U docker -p 5432 -d gis
```
### JOIN SHP and CSV
You can create a new table by joining the CSV and the SHP elements on multiple columns.
```sql
CREATE TABLE new_table_name AS SELECT c.*,s.* FROM shp as s INNER JOIN csv as c ON s.FIRST = c.FIRST AND s.SECOND = c.SECOND AND s.THIRD = c.THIRD;
```

### Create SHP from PostGIS
You can create a new shapefile form your PostGIS DB with:
```shell
pgsql2shp -h db -u docker -P docker gis "SELECT * FROM new_table_name"
```

### Backup your DB
Connect to your backupdb app by using:
```shell
docker-compose run backupdb bash
```
Backup your db like you would do everywhere else with:
```shell
pg_dump --no-owner gis > dump.sql
```
Copy the backup to `/backup` and you will find it in your home directory and the `postgis-analysis` folder.
