{% macro get_payment_type_description(payment_type) -%}
    CASE {{ dbt.safe_cast(payment_type, api.Column.translate_type("string")) }}
        WHEN '1.0' THEN 'Credit card'
        WHEN '1'   THEN 'Credit card'
        WHEN '2.0' THEN 'Cash'
        WHEN '2'   THEN 'Cash'
        WHEN '3.0' THEN 'No charge'
        WHEN '3'   THEN 'No charge'
        WHEN '4.0' THEN 'Dispute'
        WHEN '4'   THEN 'Dispute'
        WHEN '5.0' THEN 'Unknown'
        WHEN '5'   THEN 'Unknown'
        WHEN '6.0' THEN 'Voided trip'
        WHEN '6'   THEN 'Voided trip'
        ELSE 'EMPTY'
    END
{%- endmacro %}
