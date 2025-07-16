-- PREREQUISITE: Execute statements in setup.sql
USE ROLE KAMESH_DEMOS;
USE KAMESH_DEMOS.DATA;
USE WAREHOUSE KAMESH_DEMOS_S;

-- Load sample images

COPY FILES 
  INTO 
   @data.image_files/
  FROM
   @github.KAMESH_SFGUIDE_GETTING_STARTED_WITH_CORTEX_AISQL/branches/main/data/images/;

ALTER stage data.image_files REFRESH;

-- Image Files table
create or replace table IMAGES as
select to_file(file_url) img_file, 
    DATEADD(SECOND, UNIFORM(0, 13046400, RANDOM()),
    TO_TIMESTAMP('2025-01-01 00:00:00')) as created_at,
    UNIFORM(0, 200, RANDOM()) as user_id,
    * from directory(@KAMESH_DEMOS.DATA.IMAGE_FILES);

create or replace stage SRC encryption = (TYPE = 'SNOWFLAKE_SSE') directory = ( ENABLE = true );

ls @github.KAMESH_SFGUIDE_GETTING_STARTED_WITH_CORTEX_AISQL/branches/main;

COPY FILES 
 INTO 
   @data.src/
 FROM
   @github.KAMESH_SFGUIDE_GETTING_STARTED_WITH_CORTEX_AISQL/branches/main/snowbooks_extras.py;

ALTER stage data.src REFRESH;
    
