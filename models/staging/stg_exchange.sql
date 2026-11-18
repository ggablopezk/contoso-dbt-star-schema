


with source as (

    select * from {{ source('contoso', 'currencyexchange') }}

),

renamed as (

    select
        date,
        exchange,
        fromcurrency,
        tocurrency
    from source

)

select * from renamed