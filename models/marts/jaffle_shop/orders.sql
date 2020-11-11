with orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
)

,payments as (
    select * from {{ ref('stg_stripe__payments') }}
)

,final as (
    select
        ord.order_id
        ,ord.customer_id
        ,ord.status
        ,sum(pmt.amount) as total_payment_amount
        ,sum(case when pmt.status = 'fail' then 0 else pmt.amount end) as total_success_amount
        ,sum(case when pmt.status = 'fail' then pmt.amount else 0 end) as total_fail_amount
    from orders ord
    left outer join payments pmt
        on ord.order_id = pmt.order_id
    group by 
        ord.order_id
        ,ord.customer_id
        ,ord.status
)

select * from final