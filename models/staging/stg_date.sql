with source as (

    select * from {{ source('contoso', 'date') }}

),

renamed as (

    select
        datekey,
        date,
    --day
        workingdaynumber,
        dayofweeknumber,
        workingday,
        dayofweekshort,
        dayofweek,
    --month        
        monthnumber,
        month,
        monthshort,  
        quarter,
    --year
        year,
        yearquarternumber,
        yearmonthnumber,
        yearmonth,
        yearquarter,
        yearmonthshort
    from source

)

select * from renamed