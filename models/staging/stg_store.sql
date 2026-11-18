
with source as (

    select * from {{ source('contoso', 'store') }}

),

renamed as (

    select

        opendate,
        closedate,
        geoareakey,
        squaremeters,
        storekey,
        storecode,
        status,
        countrycode,
        countryname,
        state,
        description
    from source

)

select * from renamed