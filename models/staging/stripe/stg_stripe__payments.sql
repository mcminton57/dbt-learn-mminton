with source as (

    select * from {{ source('stripe', 'payment') }}

)

,staged as (

    select 
        id as payment_id
        ,orderid as order_id
        ,paymentmethod
        ,status
        ,to_number(amount)/100 as amount
        ,created
        ,_batched_at
    from source
    
)

select * from staged