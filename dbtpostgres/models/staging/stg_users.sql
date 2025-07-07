
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/


SELECT id as user_id, name as user_name, email as user_email FROM public.users

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
