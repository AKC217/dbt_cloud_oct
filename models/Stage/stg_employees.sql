WITH src AS (
    SELECT 
        EMPLOYEE_ID,
        EMPLOYEE_FIRST_NAME,
        EMPLOYEE_LAST_NAME,
        EMPLOYEE_ADDRESS,
        EMPLOYEE_CITY,
        EMPLOYEE_STATE,
        EMPLOYEE_ZIP_CODE,
        EMPLOYEE_MOBILE,
        EMPLOYEE_FIXEDLINE,
        EMPLOYEE_EMAIL,
        EMPLOYEE_GENDER,
        EMPLOYEE_AGE,
        POSITION_TYPE,
        DEALERSHIP_ID,
        SALARY,
        DEALERSHIP_MANAGER,
        REGION,
        HIRE_DATE,
        DATE_ENTERED
    FROM {{ source('src_mkmotors', 'stg_employees') }}
)

SELECT
    -- Business Key
    ANALYTICS.DBT_AKANKSHA.SEQE.NEXTVAL AS EMPLOYEE_KEY,
    EMPLOYEE_ID,

    -- Derived Name
    {{ name('EMPLOYEE_FIRST_NAME', 'EMPLOYEE_LAST_NAME') }} AS EMPLOYEE_NAME,

    EMPLOYEE_ADDRESS,
    EMPLOYEE_CITY,
    EMPLOYEE_STATE,
    EMPLOYEE_ZIP_CODE,
    EMPLOYEE_MOBILE,

    -- Fixed Line Formatting
    {{ format('EMPLOYEE_FIXEDLINE') }} AS EMPLOYEE_FIXED_LINE,

    EMPLOYEE_EMAIL,

    -- Gender Label Using Macro
    {{ gender('EMPLOYEE_GENDER') }} AS EMPLOYEE_GENDER,

    EMPLOYEE_AGE,

    -- Age Group Using Macro
    {{ age('EMPLOYEE_AGE') }} AS AGE_GROUP,

    POSITION_TYPE,
    DEALERSHIP_ID,
    DEALERSHIP_MANAGER,

    SALARY AS EMPLOYEE_SALARY,
    REGION AS EMPLOYEE_REGION,

    -- Date Keys Using Macro
    {{ date('HIRE_DATE') }} AS HIRED_DATE_KEY,
    {{ date('DATE_ENTERED') }} AS INSERT_DK,
    -- {{ date('DATE_ENTERED') }} AS UPDATE_DK

FROM src

