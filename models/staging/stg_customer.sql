with source as (

    select * from {{ source('contoso', 'customer') }}

),

renamed as (

    select
        customerkey,
        gender,
        countryfull AS country,
        statefull AS state,
        city,
        birthday,
        company,
        vehicle,
        occupation
        
    from source

)

select * from renamed