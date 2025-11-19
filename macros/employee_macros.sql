{% macro name(first, last) %}
    {{ first }} || ' ' || {{ last }}
{% endmacro %}


{% macro format(col) %}
    '(' || LEFT({{ col }}, 3) || ') '
    || SUBSTRING({{ col }}, 4, 3) || '-'
    || RIGHT({{ col }}, 4)
{% endmacro %}


{% macro date(col) %}
    TO_NUMBER(TO_CHAR({{ col }}, 'YYYYMMDD'))
{% endmacro %}


{% macro age(col) %}
    CASE
        WHEN {{ col }} < 30 THEN 'Youngest'
        WHEN {{ col }} BETWEEN 30 AND 60 THEN 'Middle'
        ELSE 'Senior'
    END
{% endmacro %}


{% macro gender(col) %}
    CASE UPPER({{ col }})
        WHEN 'M' THEN 'Male'
        WHEN 'F' THEN 'Female'
        ELSE 'Other'
    END
{% endmacro %}