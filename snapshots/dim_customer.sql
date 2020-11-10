{% snapshot customer_snapshot %}

{{
    config(
        target_database='analytics',
        target_schema='dbt_mminton',
        strategy='check',
        unique_key='customer_id',
        check_cols=['value_field_hash'],
    )
}}

select * from {{ ref('customers') }}

{% endsnapshot %}