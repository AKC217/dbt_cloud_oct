{% macro jodo(col1, col2) %}
 {{ col1 }} || ' ' || {{ col2 }}
{% endmacro %}
-----mod tab

{% macro mod_tab(table_name) %}
    {% set query %}
        UPDATE {{ table_name }}
        SET updated_as = CURRENT_TIMESTAMP;
    {% endset %}
    {% do run_query(query) %}
{% endmacro %}










{% macro show_emps() %}
    select employee_name from {{ ref('stg_employees') }}
{% endmacro %}

{% macro unload() %}
{% do run_query("create or replace stage stage_analytics") %}
{% do run_query("copy into @stage_analytics from stg_nations partition by (region_id) 
file_format=(type=csv compression = none null_if=(' ')) header=true; ") %}
{% endmacro %}
