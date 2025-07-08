
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/


SELECT id as product_id, name as product_name, description as product_description, price as product_price FROM public.products

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
