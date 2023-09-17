{%snapshot check_order %}
{{
    config(
          target_schema='snapshots',
          strategy='check',
          unique_key='id',
          check_cols=['status']        
    )
}}
    select *from {{ source("staging","orders") }} 

{% endsnapshot %}