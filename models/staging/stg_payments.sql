SELECT
    ID AS PAYMENT_ID
    ,ORDERID AS ORDER_ID
    ,PAYMENTMETHOD
    ,STATUS
    ,TO_NUMBER(AMOUNT)/100 AS AMOUNT
    ,CREATED
FROM RAW.STRIPE.PAYMENT