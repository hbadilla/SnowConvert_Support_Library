-- <copyright file="WEEKNUMBER_OF_QUARTER_UDF.sql" company="Mobilize.Net">
--        Copyright (C) Mobilize.Net info@mobilize.net - All Rights Reserved
-- 
--        This file is part of the Mobilize Frameworks, which is
--        proprietary and confidential.
-- 
--        NOTICE:  All information contained herein is, and remains
--        the property of Mobilize.Net Corporation.
--        The intellectual and technical concepts contained herein are
--        proprietary to Mobilize.Net Corporation and may be covered
--        by U.S. Patents, and are protected by trade secret or copyright law.
--        Dissemination of this information or reproduction of this material
--        is strictly forbidden unless prior written permission is obtained
--        from Mobilize.Net Corporation.
-- </copyright>

-- ======================================================================
-- RETURNS THE WEEK NUMBER FROM THE START OF THE QUARTER TO THE SPECIFIED DATE.
-- HAS THE SAME BEHAVIOR AS THE WEEKNUMBER_OF_QUARTER(DATE, 'ISO') FUNCTION
-- WITH TERADATA CALENDAR
-- PARAMETERS:
--     INPUT: TIMESTAMP_TZ. DATE TO GET THE WEEK NUMBER OF THE QUARTER
-- RETURNS:
--     AN INTEGER THAT REPRESENTS THE NUMBER OF THE WEEK IN THE QUARTER
-- EQUIVALENT:
--     TERADATA'S WEEKNUMBER_OF_QUARTER FUNCTIONALITY
-- EXAMPLE:
--     SELECT WEEKNUMBER_OF_QUARTER(DATE '2023-01-01'),
--     WEEKNUMBER_OF_QUARTER(DATE '2022-10-27')
--     RETURNS 1, 4
-- ======================================================================
CREATE OR REPLACE FUNCTION PUBLIC.WEEKNUMBER_OF_QUARTER_UDF(INPUT TIMESTAMP_TZ)
RETURNS INT
LANGUAGE SQL
IMMUTABLE
AS
$$
    IFF(DAYOFWEEK(INPUT)=0,DATEDIFF('WEEK',DATE_TRUNC('QUARTER',INPUT), INPUT)+1,DATEDIFF('WEEK',DATE_TRUNC('QUARTER',INPUT), INPUT))
$$;

-- ======================================================================
-- RETURNS THE WEEK NUMBER FROM THE START OF THE QUARTER TO THE SPECIFIED DATE.
-- HAS THE SAME BEHAVIOR AS THE WEEKNUMBER_OF_QUARTER(DATE, 'ISO') FUNCTION
-- WITH ISO CALENDAR FROM TERADATA
-- PARAMETERS:
--     INPUT: TIMESTAMP_TZ. DATE TO GET THE WEEK NUMBER OF THE QUARTER
-- RETURNS:
--     AN INTEGER THAT REPRESENTS THE NUMBER OF THE WEEK IN THE QUARTER
-- EQUIVALENT:
--     TERADATA'S WEEKNUMBER_OF_QUARTER FUNCTIONALITY
-- EXAMPLE:
--     SELECT WEEKNUMBER_OF_QUARTER(DATE '2022-05-01', 'ISO'),
--     WEEKNUMBER_OF_QUARTER(DATE '2022-07-06', 'ISO')
--     RETURNS 4, 1
-- ======================================================================
CREATE OR REPLACE FUNCTION PUBLIC.WEEKNUMBER_OF_QUARTER_ISO_UDF(INPUT TIMESTAMP_TZ)
RETURNS INT
LANGUAGE SQL
IMMUTABLE
AS
$$
    CASE
        WHEN WEEKISO(INPUT)<=13 THEN WEEKISO(INPUT)
        WHEN WEEKISO(INPUT)<=26 THEN (WEEKISO(INPUT) - 13)
        WHEN WEEKISO(INPUT)<=39 THEN (WEEKISO(INPUT) - 26)
        ELSE (WEEKISO(INPUT) - 39)
    END
$$;

-- ======================================================================
-- RETURNS THE WEEK NUMBER FROM THE START OF THE QUARTER TO THE SPECIFIED DATE.
-- HAS THE SAME BEHAVIOR AS THE WEEKNUMBER_OF_QUARTER(DATE, 'COMPATIBLE') FUNCTION
-- WITH COMPATIBLE CALENDAR FROM TERADATA
-- PARAMETERS:
--     INPUT: TIMESTAMP_TZ. DATE TO GET THE WEEK NUMBER OF THE QUARTER
-- RETURNS:
--     AN INTEGER THAT REPRESENTS THE NUMBER OF THE WEEK IN THE QUARTER
-- EQUIVALENT:
--     TERADATA'S WEEKNUMBER_OF_QUARTER FUNCTIONALITY
-- EXAMPLE:
--     SELECT WEEKNUMBER_OF_QUARTER(DATE '2022-05-01', 'COMPATIBLE'),
--     WEEKNUMBER_OF_QUARTER(DATE '2022-07-06', 'COMPATIBLE')
--     RETURNS 5, 1
-- ======================================================================
CREATE OR REPLACE FUNCTION PUBLIC.WEEKNUMBER_OF_QUARTER_COMPATIBLE_UDF(INPUT TIMESTAMP_TZ)
RETURNS INT
LANGUAGE SQL
IMMUTABLE
AS
$$
    TRUNC(DATEDIFF('DAY',DATE_TRUNC('QUARTER',INPUT), INPUT)/7) + 1
$$;
