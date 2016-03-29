--building query to pull columns from Access to use in R denormalized

SELECT 
Site.Site AS [site], 
Location.Transect_Location AS [transect_point],
Sample_date_time.ID AS [sample_date_time_id],
Sample_date_time.Sample_type AS [insect_trap_type],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
"insect" AS [sample_type]
FROM (Site 
	INNER JOIN Location ON Site.ID = Location.Site_ID) 
	INNER JOIN Sample_date_time ON Location.ID = Sample_date_time.Location_ID
WHERE Sample_date_time.Sample_type IS NOT "Quadrat";

SELECT 
Site.Site AS [site], 
Location.Transect_Location AS [transect_point],
Sample_date_time.Sample_type AS [insect_trap_type],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
Sample_date_time.ID AS [sample_id],
"insect" AS [sample_type]
FROM (Site 
	INNER JOIN Location ON Site.ID = Location.Site_ID) 
	INNER JOIN Sample_date_time ON Location.ID = Sample_date_time.Location_ID
WHERE Sample_date_time.Sample_type <> "Quadrat";

SELECT 
Site.Site AS [site], 
Location.Transect_Location AS [transect_point],
Sampling_Round.Round_name AS [round],
Sample_date_time.ID AS [sample_id],
Sample_date_time.Sample_type AS [insect_trap_type],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
"insect" AS [sample_type]
FROM Sampling_Round 
	INNER JOIN ((Site 
	INNER JOIN Location ON Site.ID = Location.Site_ID) 
	INNER JOIN Sample_date_time ON Location.ID = Sample_date_time.Location_ID) 
								ON Sampling_Round.ID = Sample_date_time.Sampling_round_ID
WHERE (((Sample_date_time.Sample_type)<>"Quadrat"));


SELECT 
Site.Site AS [site], 
Location.Transect_Location AS [transect_point],
Sampling_Round.Round_name AS [round],
Sample_date_time.ID AS [sample_id],
Sample_date_time.Sample_type AS [insect_trap_type],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
"insect" AS [sample_type],
Insect_Species.Bee_or_Butterfly AS [insect_type],
Insect_Species.Family AS [insect_family],
Insect_Species.Tribe AS [insect_tribe],
Insect_Species.Genus AS [insect_genus],
Insect_Species.species AS [insect_species]
FROM Insect_Species 
	INNER JOIN ((Sampling_Round 
	INNER JOIN ((Site 
	INNER JOIN Location ON Site.ID = Location.Site_ID) 
	INNER JOIN Sample_date_time ON Location.ID = Sample_date_time.Location_ID) 
								ON Sampling_Round.ID = Sample_date_time.Sampling_round_ID) 
	INNER JOIN Insect_Sample_Barcodes 
		ON Sample_date_time.ID = Insect_Sample_Barcodes.Sample_date_time_ID) 
		ON Insect_Species.ID = Insect_Sample_Barcodes.Corrected_Insect_Species_ID
WHERE (((Sample_date_time.Sample_type)<>"Quadrat"));

--Trying to figure out why all the data isn't being returned.
SELECT 
Site.Site AS [site], 
Location.Transect_Location AS [transect_point],
Sampling_Round.Round_name AS [round],
Sample_date_time.ID AS [sample_id],
Sample_date_time.Sample_type AS [insect_trap_type],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
"insect" AS [sample_type],
Insect_Species.Bee_or_Butterfly AS [insect_type],
Insect_Species.Family AS [insect_family],
Insect_Species.Tribe AS [insect_tribe],
Insect_Species.Genus AS [insect_genus],
Insect_Species.species AS [insect_species],
Insect_Sample_Barcodes.ID AS [insect_barcode],
Insect_Box_numbers.Box_number AS [insect_box]
FROM Insect_box_numbers 
	INNER JOIN (Insect_Species 
	INNER JOIN ((Sampling_Round 
	INNER JOIN ((Site 
	INNER JOIN Location ON Site.ID = Location.Site_ID) 
	INNER JOIN Sample_date_time ON Location.ID = Sample_date_time.Location_ID) 
								ON Sampling_Round.ID = Sample_date_time.Sampling_round_ID) 
	INNER JOIN Insect_Sample_Barcodes ON Sample_date_time.ID = Insect_Sample_Barcodes.Sample_date_time_ID) ON Insect_Species.ID = Insect_Sample_Barcodes.Corrected_Insect_Species_ID) ON Insect_box_numbers.ID = Insect_Sample_Barcodes.Box_number
WHERE (((Sample_date_time.Sample_type)<>"Quadrat") AND Insect_Sample_Barcodes.ID = 101608);


SELECT
Site.Site AS [site], 
Location.Transect_Location AS [transect_point],
Sample_date_time.ID AS [sample_date_time_id],
Sample_date_time.Sample_type AS [insect_trap_type],
Sample_date_time.Start_date AS [sample_start_date],
Sample_date_time.Start_time AS [sample_start_time],
Sample_date_time.End_date AS [sample_end_date],
Sample_date_time.End_time AS [sample_end_time],
"insect" AS [sample_type]
FROM (Site INNER JOIN Location ON Site.ID = Location.Site_ID) INNER JOIN Sample_date_time ON Location.ID = Sample_date_time.Location_ID
WHERE (((Sample_date_time.Sample_type)<>"Quadrat"));
-- not getting the correct number of rows from the insect_barcode table because of missing data that needs to be retained.
-- Need to left join the date/site info, saving above query as site_location_date_time for left join
SELECT *
FROM (Insect_Sample_Barcodes 
	LEFT JOIN site_location_date_time 
		ON Insect_Sample_Barcodes.sample_date_time_id = site_location_date_time.sample_date_time_id)
	LEFT JOIN Insect_Species 
		ON Insect_Sample_Barcodes.Corrected_Insect_Species_ID = Insect_Species.ID;
-- the above returns 37,888 rows which is correct
--Starting to build on column headers for insect_barcodes samples
SELECT site_location_date_time.Site AS [site], 
site_location_date_time.Transect_Point AS [transect_point],
site_location_date_time.sample_date_time_id AS [sample_date_time_id],
site_location_date_time.insect_trap_type AS [insect_trap_type],
site_location_date_time.sample_start_date AS [sample_start_date],
site_location_date_time.sample_start_time AS [sample_start_time],
site_location_date_time.sample_end_date AS [sample_end_date],
site_location_date_time.sample_end_time AS [sample_end_time],
"insect" AS [sample_type],
Insect_Species.Bee_or_Butterfly AS [insect_type],
Insect_Species.Family AS [insect_family],
Insect_Species.Tribe AS [insect_tribe],
Insect_Species.Genus AS [insect_genus],
Insect_Species.species AS [insect_species],
Insect_Sample_Barcodes.ID AS [insect_barcode]
FROM (Insect_Sample_Barcodes 
	LEFT JOIN site_location_date_time ON Insect_Sample_Barcodes.sample_date_time_id = site_location_date_time.sample_date_time_id)
	LEFT JOIN Insect_Species ON Insect_Sample_Barcodes.Corrected_Insect_Species_ID = Insect_Species.ID;

SELECT site_location_date_time.Site AS [site], 
site_location_date_time.Transect_Point AS [transect_point],
site_location_date_time.sample_date_time_id AS [sample_date_time_id],
site_location_date_time.insect_trap_type AS [insect_trap_type],
site_location_date_time.sample_start_date AS [sample_start_date],
site_location_date_time.sample_start_time AS [sample_start_time],
site_location_date_time.sample_end_date AS [sample_end_date],
site_location_date_time.sample_end_time AS [sample_end_time],
"insect" AS [sample_type],
Insect_Species.Bee_or_Butterfly AS [insect_type],
Insect_Species.Family AS [insect_family],
Insect_Species.Tribe AS [insect_tribe],
Insect_Species.Genus AS [insect_genus],
Insect_Species.species AS [insect_species],
Insect_Species.Sex AS [insect_sex],
Insect_Species.Uncertianty AS [insect_species_uncertainty],
Insect_Sample_Barcodes.ID AS [insect_barcode],
Plant_Species.Family AS [insect_plant_family],
Plant_Species.Genus AS [insect_plant_genus],
Plant_Species.Species AS [insect_plant_species]
FROM ((Insect_Sample_Barcodes 
	LEFT JOIN site_location_date_time ON Insect_Sample_Barcodes.sample_date_time_id = site_location_date_time.sample_date_time_id)
	LEFT JOIN Insect_Species ON Insect_Sample_Barcodes.Corrected_Insect_Species_ID = Insect_Species.ID)
	LEFT JOIN Plant_Species ON Insect_Sample_Barcodes.Plant_Species = Plant_Species.ID;

SELECT site_location_date_time.Site AS [site], 
site_location_date_time.Transect_Point AS [transect_point],
site_location_date_time.sample_date_time_id AS [sample_date_time_id],
site_location_date_time.insect_trap_type AS [insect_trap_type],
site_location_date_time.sample_start_date AS [sample_start_date],
site_location_date_time.sample_start_time AS [sample_start_time],
site_location_date_time.sample_end_date AS [sample_end_date],
site_location_date_time.sample_end_time AS [sample_end_time],
"insect" AS [sample_type],
Insect_Species.Bee_or_Butterfly AS [insect_type],
Insect_Species.Family AS [insect_family],
Insect_Species.Tribe AS [insect_tribe],
Insect_Species.Genus AS [insect_genus],
Insect_Species.species AS [insect_species],
Insect_Species.Sex AS [insect_sex],
Insect_Species.Uncertianty AS [insect_species_uncertainty],
Insect_Sample_Barcodes.ID AS [insect_barcode],
Plant_Species.Family AS [insect_plant_family],
Plant_Species.Genus AS [insect_plant_genus],
Plant_Species.Species AS [insect_plant_species],
Insect_Box_Numbers.Box_Number AS [insect_box_number]
FROM (((Insect_Sample_Barcodes 
	LEFT JOIN site_location_date_time ON Insect_Sample_Barcodes.sample_date_time_id = site_location_date_time.sample_date_time_id)
	LEFT JOIN Insect_Species ON Insect_Sample_Barcodes.Corrected_Insect_Species_ID = Insect_Species.ID)
	LEFT JOIN Plant_Species ON Insect_Sample_Barcodes.Plant_Species = Plant_Species.ID)
	LEFT JOIN Insect_Box_Numbers ON Insect_Sample_Barcodes.Box_Number = Insect_Box_Numbers.ID;

	
--final columns from insect_barcodes
SELECT site_location_date_time.Site AS [site],
site_location_date_time.site_city AS [site_city],
site_location_date_time.site_county AS [site_county],
site_location_date_time.Transect_Point AS [transect_point],
site_location_date_time.transect_latitude AS [transect_latitude],
site_location_date_time.transect_longitude AS [transect_longitude],
site_location_date_time.insect_trap_type AS [insect_trap_type],
site_location_date_time.Sample_date_time_id AS [sample_date_time_id],
site_location_date_time.sample_round AS [sample_round],
site_location_date_time.sample_start_date AS [sample_start_date],
site_location_date_time.sample_start_time AS [sample_start_time],
site_location_date_time.sample_end_date AS [sample_end_date],
site_location_date_time.sample_end_time AS [sample_end_time],
"insect" AS [sample_type],
Insect_Species.Bee_or_Butterfly AS [insect_type],
Insect_Species.Family AS [insect_family],
Insect_Species.Tribe AS [insect_tribe],
Insect_Species.Genus AS [insect_genus],
Insect_Species.species AS [insect_species],
Insect_Species.Sex AS [insect_sex],
Insect_Species.Uncertianty AS [insect_species_uncertainty],
Insect_Sample_Barcodes.ID AS [insect_barcode],
Plant_Species.Family AS [insect_plant_family],
Plant_Species.Genus AS [insect_plant_genus],
Plant_Species.Species AS [insect_plant_species],
Plant_Species.USDA_Abrev AS [insect_plant_usda],
Insect_Box_Numbers.Box_Number AS [insect_box_number]
FROM (((Insect_Sample_Barcodes 
	LEFT JOIN site_location_date_time ON Insect_Sample_Barcodes.sample_date_time_id = site_location_date_time.sample_date_time_id)
	LEFT JOIN Insect_Species ON Insect_Sample_Barcodes.Corrected_Insect_Species_ID = Insect_Species.ID)
	LEFT JOIN Plant_Species ON Insect_Sample_Barcodes.Plant_Species = Plant_Species.ID)
	LEFT JOIN Insect_Box_Numbers ON Insect_Sample_Barcodes.Box_Number = Insect_Box_Numbers.ID;