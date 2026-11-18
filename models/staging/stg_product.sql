
with source as (

    select * from {{ source('contoso', 'product') }}

),

renamed as (

    select
            productkey,
            categorykey,
            categoryname,
            subcategoryname,
            subcategorykey,
            productname,
            productcode,
            manufacturer,
            cost,
            price,
            brand,
            color,
            weightunit,
            weight
    from source

)

select * from renamed