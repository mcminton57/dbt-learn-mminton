-- 1. Can you dynamically populate the loop list with some sql query?
-- 2. How do we stop m a k i n g a l l t h i s happen?
-- 3. Can we avoid leading commas as the solution? (should we?)
-- 4. If we have a new payment method, how do we handle this?
-- Bonus: Is there a better way?

{%- set methods = dbt_utils.get_column_values(
    table=ref('stg_stripe__payments'),
    column='paymentmethod'
) %}

with payments as (

    select * from {{ ref('stg_stripe__payments') }}

),

final as (

    select
        order_id,
        {% for payment_method in methods -%}
        sum(case when paymentmethod = '{{payment_method}}' then amount else 0 end) as {{payment_method}}_amount{% if not loop.last %},{% endif %}
        {% endfor %}
    from payments
    group by 1

)

select * from final
