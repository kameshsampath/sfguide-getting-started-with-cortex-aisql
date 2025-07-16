-- PREREQUISITE: Execute statements in setup.sql
USE ROLE KAMESH_DEMOS;
USE KAMESH_DEMOS.DATA;
USE WAREHOUSE KAMESH_DEMOS_S;

-- Image Files table
create or replace table IMAGES as
select to_file(file_url) img_file, 
    DATEADD(SECOND, UNIFORM(0, 13046400, RANDOM()),
    TO_TIMESTAMP('2025-01-01 00:00:00')) as created_at,
    UNIFORM(0, 200, RANDOM()) as user_id,
    * from directory(@KAMESH_DEMOS.DATA.IMAGE_FILES);
