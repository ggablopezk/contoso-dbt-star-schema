with source as (

    select * from {{ source('contoso', 'sales') }}

),

renamed as (

    select
        customerkey,
     --order      
        linenumber,
        orderkey,
        orderdate,
        deliverydate,
        storekey,
    -- product
        productkey,
        quantity,
        unitprice,
        netprice,
        unitcost,
    -- exchange    
        currencycode,
        exchangerate
    from source

)

select * from renamed