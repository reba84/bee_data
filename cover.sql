
--Building query for pulling all the data from the cover_count table with new 
--column headers for denormalized data in R
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
FROM (Sampling_Round 
      INNER JOIN
      (  Site 
         INNER JOIN 
         (  (Location 
                INNER JOIN Sample_date_time ON Location.ID = Sample_date_time.Location_ID
            ) 
                INNER JOIN Quadrat ON Location.ID = Quadrat.Location_ID
          ) ON Site.ID = Location.Site_ID
       ) ON Sampling_Round.ID = Sample_date_time.Sampling_round_ID
      ) 
      INNER JOIN 
      Cover_counts ON (Sample_date_time.ID = Cover_counts.Sample_date_time_ID) 
                        AND (Quadrat.ID = Cover_counts.Quadrat_ID)
WHERE Sample_Date_time.Sample_type = "quadrat";

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
Cover_counts.Veg_count AS [veg_count],
Cover_counts.Litter_count AS [litter_count],
Cover_counts.Bare_count AS [bare_count],
Cover_counts.Rocky_count AS [rocky_count],
Cover_counts.Percent_cov AS [percent_cov],
Cover_counts.Woody_Cover AS [woody_cover],
Cover_counts.Notes AS [cover_notes]
FROM (Sampling_Round 
        INNER JOIN (Site 
        INNER JOIN ((Location 
        INNER JOIN Sample_date_time 
            ON Location.ID = Sample_date_time.Location_ID) 
        INNER JOIN Quadrat ON Location.ID = Quadrat.Location_ID) 
            ON Site.ID = Location.Site_ID) 
            ON Sampling_Round.ID = Sample_date_time.Sampling_round_ID) 
        INNER JOIN Cover_counts 
            ON (Sample_date_time.ID = Cover_counts.Sample_date_time_ID) 
                AND (Quadrat.ID = Cover_counts.Quadrat_ID)
WHERE Sample_Date_time.Sample_type = "quadrat";


--using a sub query to see if I can figure out why I'm missing data
SELECT Cover_counts.ID, Cover_counts.sample_date_time_id
FROM Cover_counts 
    LEFT JOIN (SELECT Site.Site AS [site], 
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
                    Cover_counts.Veg_count AS [veg_count],
                    Cover_counts.Litter_count AS [litter_count],
                    Cover_counts.Bare_count AS [bare_count],
                    Cover_counts.Rocky_count AS [rocky_count],
                    Cover_counts.Percent_cov AS [percent_cov],
                    Cover_counts.Woody_Cover AS [woody_cover],
                    Cover_counts.Notes AS [cover_notes]
                    FROM (Sampling_Round 
                                    INNER JOIN (Site 
                                    INNER JOIN ((Location 
                                    INNER JOIN Sample_date_time 
                                        ON Location.ID = Sample_date_time.Location_ID) 
                                    INNER JOIN Quadrat ON Location.ID = Quadrat.Location_ID) 
                                        ON Site.ID = Location.Site_ID) 
                                        ON Sampling_Round.ID = Sample_date_time.Sampling_round_ID) 
                                    INNER JOIN Cover_counts 
                                        ON (Sample_date_time.ID = Cover_counts.Sample_date_time_ID) 
                                            AND (Quadrat.ID = Cover_counts.Quadrat_ID)
                    WHERE Sample_Date_time.Sample_type = "quadrat") AS my_table 
    ON Cover_counts.sample_date_time_id = my_table.sample_date_time_id
WHERE my_table.sample_date_time_id IS NULL;
-- gives me the records that are missing data so I can find them and fix them

--Find and update all rows that do no thave date_times from cover counts table
SELECT Cover_counts.ID, Cover_counts.sample_date_time_id
FROM Cover_counts
WHERE Cover_counts.ID >= 22200 AND Cover_counts.ID <= 22229

SELECT Cover_counts.ID, Cover_counts.sample_date_time_id
FROM Cover_counts
WHERE (Cover_counts.ID >= 23460 AND Cover_counts.ID <= 23518) 
        AND (Cover_counts.sample_date_time_id = 4143)


UPDATE Cover_counts
SET Cover_counts.sample_date_time_id = 32907
WHERE Cover_counts.ID >= 22200 AND Cover_counts.ID <= 22229
--Changed range of IDs to sample date time 32907 from 4142 because 4142 doesn't 
--exist in sample_date_time

SELECT Cover_counts.ID, Cover_counts.sample_date_time_id
FROM Cover_counts
WHERE (Cover_counts.ID >= 23460 AND Cover_counts.ID <= 23518) 
        AND (Cover_counts.sample_date_time_id = 4143)

-- change this to 32908

UPDATE Cover_counts
SET Cover_counts.sample_date_time_id = 32908
WHERE (Cover_counts.ID >= 23460 AND Cover_counts.ID <= 23518) 
        AND (Cover_counts.sample_date_time_id = 4143)

-- fix quadrats that didn't have assigned dates from the Sample_date_time table 
--by checking original data in lab
SELECT Cover_counts.ID, Cover_counts.sample_date_time_id
FROM Cover_counts
WHERE (Cover_counts.ID >= 22800 AND Cover_counts.ID <= 22829)

UPDATE Cover_counts
SET Cover_counts.sample_date_time_id = 3163
WHERE (Cover_counts.ID >= 22800 AND Cover_counts.ID <= 22829);

SELECT Cover_counts.ID, Cover_counts.sample_date_time_id
FROM Cover_counts
WHERE (Cover_counts.ID >= 39450 AND Cover_counts.ID <= 39479);


UPDATE Cover_counts
SET Cover_counts.sample_date_time_id = 32534
WHERE (Cover_counts.ID >= 39450 AND Cover_counts.ID <= 39479);

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
Cover_counts.Veg_count AS [veg_count],
Cover_counts.Litter_count AS [litter_count],
Cover_counts.Bare_count AS [bare_count],
Cover_counts.Rocky_count AS [rocky_count],
Cover_counts.Percent_cov AS [percent_cov],
Cover_counts.Woody_Cover AS [woody_cover],
Cover_counts.Notes AS [cover_notes]
FROM (Sampling_Round 
                INNER JOIN (Site 
                INNER JOIN ((Location 
                INNER JOIN Sample_date_time 
                    ON Location.ID = Sample_date_time.Location_ID) 
                INNER JOIN Quadrat ON Location.ID = Quadrat.Location_ID) 
                    ON Site.ID = Location.Site_ID) 
                    ON Sampling_Round.ID = Sample_date_time.Sampling_round_ID) 
                INNER JOIN Cover_counts 
                    ON (Sample_date_time.ID = Cover_counts.Sample_date_time_ID) 
                        AND (Quadrat.ID = Cover_counts.Quadrat_ID)
WHERE Sample_Date_time.Sample_type = "quadrat";

-- Now retruns 12937 rows which is the same number of rows that are in the cover_counts table

-- Final rows from cover_counts
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
Sample_date_time.sample_type AS [sample_type],
"cover" AS [quadrat_type],
Quadrat.Quadrat AS [quadrat_name],
Cover_counts.Veg_count AS [quadrat_veg_count],
Cover_counts.Litter_count AS [quadrat_litter_count],
Cover_counts.Bare_count AS [quadrat_bare_count],
Cover_counts.Rocky_count AS [quadrat_rocky_count],
Cover_counts.Percent_cov AS [quadrat_percent_cov],
Cover_counts.Woody_Cover AS [quadrat_woody_cover],
Cover_counts.Notes AS [quadrat_cover_notes]
FROM (Sampling_Round 
                INNER JOIN (Site 
                INNER JOIN ((Location 
                INNER JOIN Sample_date_time 
                    ON Location.ID = Sample_date_time.Location_ID) 
                INNER JOIN Quadrat ON Location.ID = Quadrat.Location_ID) 
                    ON Site.ID = Location.Site_ID) 
                    ON Sampling_Round.ID = Sample_date_time.Sampling_round_ID) 
                INNER JOIN Cover_counts 
                    ON (Sample_date_time.ID = Cover_counts.Sample_date_time_ID) 
                        AND (Quadrat.ID = Cover_counts.Quadrat_ID);