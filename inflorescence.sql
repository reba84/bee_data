--building query to pull columns for denormalized data to use in R
SELECT
Site.Site AS [site], 
Site.City AS [site_city],
Site.County AS [site_county],
Location.Transect_Location AS [transect_point],
Location.Latitude AS [transect_latitude],
Location.Longitude AS [transect_longitude],
Sample_date_time.ID AS [sample_date_time_id],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
Sampling_Round.Round_Name AS [sample_round],
"quadrat" AS [sample_type]
FROM ((Site 
	INNER JOIN Location ON Site.ID = Location.Site_ID) 
	INNER JOIN Sample_date_time ON Location.ID = Sample_date_time.Location_ID)
	INNER JOIN Sampling_Round ON Sample_date_time.Sampling_round_ID = Sampling_Round.ID
WHERE (((Sample_date_time.Sample_type) = "Quadrat"));

SELECT
Site.Site, Location.Transect_location, Sampling_Round.Round_Name, COUNT(*)
FROM ((Site 
	INNER JOIN Location ON Site.ID = Location.Site_ID) 
	INNER JOIN Sample_date_time ON Location.ID = Sample_date_time.Location_ID)
	INNER JOIN Sampling_Round ON Sample_date_time.Sampling_round_ID = Sampling_Round.ID
WHERE (((Sample_date_time.Sample_type) = "Quadrat"))
GROUP BY Site.Site, Location.Transect_location, Sampling_Round.Round_Name;

SELECT
Site.Site AS [site], 
Site.City AS [site_city],
Site.County AS [site_county],
Location.Transect_Location AS [transect_point],
Location.Latitude AS [transect_latitude],
Location.Longitude AS [transect_longitude],
Sample_date_time.ID AS [sample_date_time_id],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
Sampling_Round.Round_Name AS [sample_round],
"quadrat" AS [sample_type]
FROM ((Site 
	INNER JOIN Location ON Site.ID = Location.Site_ID) 
	INNER JOIN Sample_date_time ON Location.ID = Sample_date_time.Location_ID)
	INNER JOIN Sampling_Round ON Sample_date_time.Sampling_round_ID = Sampling_Round.ID
WHERE (((Sample_date_time.Sample_type) = "Quadrat"))
ORDER BY Site.Site, Location.transect_point ASC, Sample_date_time.sample_end_date ASC;

--There are 425 quadrat rows because Balcones canyonlands has two quadrat 
--samples for round_1 2013 because rain. Then need to be matched with correct 
--pan or net dates in analysis.


SELECT
Site.Site AS [site], 
Site.City AS [site_city],
Site.County AS [site_county],
Location.Transect_Location AS [transect_point],
Location.Latitude AS [transect_latitude],
Location.Longitude AS [transect_longitude],
Sample_date_time.ID AS [sample_date_time_id],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
Sampling_Round.Round_Name AS [sample_round],
"quadrat" AS [sample_type],
Quadrat.ID AS [quadrat_id],
Quadrat.Quadrat AS [quadrat_name]
FROM (((Site 
	INNER JOIN Location ON Site.ID = Location.Site_ID) 
	INNER JOIN Sample_date_time ON Location.ID = Sample_date_time.Location_ID)
	INNER JOIN Sampling_Round ON Sample_date_time.Sampling_round_ID = Sampling_Round.ID)
	INNER JOIN Quadrat on Location.ID = Quadrat.Location_ID
WHERE (((Sample_date_time.Sample_type) = "Quadrat"));

--12750 rows.  425 date times for two years at all field sites, and 
--30 quadrats in each date time. 

SELECT
Site.Site AS [site], 
Site.City AS [site_city],
Site.County AS [site_county],
Location.Transect_Location AS [transect_point],
Location.Latitude AS [transect_latitude],
Location.Longitude AS [transect_longitude],
Sample_date_time.ID AS [sample_date_time_id],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
Sampling_Round.Round_Name AS [sample_round],
"quadrat" AS [sample_type],
Quadrat.Quadrat AS [quadrat_name],
Inflorescence_count.Inflorescence_count AS [inflorescence_count],
Inflorescence_count.notes AS [inflorescence_notes]

FROM Inflorescence_count LEFT JOIN Quadrat.ID = Inflorescence_count.Quadrat_ID 


--There rows in inflorescence count that don't have a sample date time.  
--They are trying to have sample date time id= 4142 They are from wildflower center.  
--I believe these are dates from 2012 when wild 1 was resampled because shalene had a fever.

SELECT
Site.Site AS [site], 
Site.City AS [site_city],
Site.County AS [site_county],
Location.Transect_Location AS [transect_point],
Location.Latitude AS [transect_latitude],
Location.Longitude AS [transect_longitude],
Sample_date_time.ID AS [sample_date_time_id],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
Sampling_Round.Round_Name AS [sample_round],
"quadrat" AS [sample_type],
Quadrat.Quadrat AS [quadrat_name],
Plant_Species.Genus,
Plant_Species.Species,
Plant_Species.USDA_Abrev,
Inflorescence_count.Inflorescence_count AS [inflorescence_count],
Inflorescence_count.notes AS [inflorescence_notes]
FROM Plant_species 
	INNER JOIN (Sampling_Round 
	INNER JOIN (Site 
	INNER JOIN (Location 
	INNER JOIN (Quadrat 
	INNER JOIN (Sample_date_time 
	INNER JOIN Inflorescence_count 
		ON Sample_date_time.ID = Inflorescence_count.Sample_date_time_ID) 
		ON Quadrat.ID = Inflorescence_count.Quadrat_ID) 
		ON (Location.ID = Sample_date_time.Location_ID) 
			AND (Location.ID = Quadrat.Location_ID)) 
		ON Site.ID = Location.Site_ID) 
		ON Sampling_Round.ID = Sample_date_time.Sampling_round_ID) 
		ON Plant_species.ID = Inflorescence_count.Plants_Species_ID;


SELECT
Site.Site AS [site], 
Site.City AS [site_city],
Site.County AS [site_county],
Location.Transect_Location AS [transect_point],
Location.Latitude AS [transect_latitude],
Location.Longitude AS [transect_longitude],
Sample_date_time.ID AS [sample_date_time_id],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
Sampling_Round.Round_Name AS [sample_round],
"quadrat" AS [sample_type],
Quadrat.Quadrat AS [quadrat_name]
FROM Plant_species, (Sampling_Round 
	INNER JOIN (Site 
	INNER JOIN ((Location 
	INNER JOIN Sample_date_time 
		ON Location.ID = Sample_date_time.Location_ID) 
	INNER JOIN Quadrat 
		ON Location.ID = Quadrat.Location_ID) 
		ON Site.ID = Location.Site_ID) 
		ON Sampling_Round.ID = Sample_date_time.Sampling_round_ID) 
			INNER JOIN Cover_counts 
				ON (Sample_date_time.ID = Cover_counts.Sample_date_time_ID) 
					AND (Quadrat.ID = Cover_counts.Quadrat_ID);
-- Final inflorescence rows
SELECT
Site.Site AS [site], 
Site.City AS [site_city],
Site.County AS [site_county],
Location.Transect_Location AS [transect_point],
Location.Latitude AS [transect_latitude],
Location.Longitude AS [transect_longitude],
Sample_date_time.ID AS [sample_date_time_id],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
Sampling_Round.Round_Name AS [sample_round],
Sample_date_time.Sample_type AS [sample_type],
Quadrat.Quadrat AS [quadrat_name],
"inflorescence" AS [quadrat_type],
Plant_Species.Family AS [quadrat_plant_family], 
Plant_Species.Genus AS [quadrat_plant_genus],
Plant_Species.Species AS [quadrat_plant_species],
Plant_Species.USDA_Abrev AS [quadrat_plant_usda],
Inflorescence_count.Inflorescence_count AS [inflorescence_count],
Inflorescence_count.notes AS [inflorescence_notes]
FROM Plant_species 
	INNER JOIN (Sampling_Round 
	INNER JOIN (Site 
	INNER JOIN (Location 
	INNER JOIN (Quadrat 
	INNER JOIN (Sample_date_time 
	INNER JOIN Inflorescence_count 
		ON Sample_date_time.ID = Inflorescence_count.Sample_date_time_ID) 
		ON Quadrat.ID = Inflorescence_count.Quadrat_ID) 
		ON (Location.ID = Sample_date_time.Location_ID) 
			AND (Location.ID = Quadrat.Location_ID)) 
		ON Site.ID = Location.Site_ID) 
		ON Sampling_Round.ID = Sample_date_time.Sampling_round_ID) 
		ON Plant_species.ID = Inflorescence_count.Plants_Species_ID;
