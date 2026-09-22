-- One row per customer order.
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- Amounts: order_amount is the gross order value before discounts and returns;
-- discount_amount and returned_amount are the discounts and returns/allowances
-- credited against the order; revenue is the net order revenue
-- (order_amount - discount_amount - returned_amount).
-- Customer-history flags are computed as of the order: customer_order_number is
-- the customer's 1-based order sequence, is_repeat_order = customer_order_number > 1,
-- and customer_is_multi_category is true once the customer has bought from two or
-- more product categories (up to and including this order).
select
    cast(null as varchar) as order_id,
    cast(null as date   ) as order_date,
    cast(null as varchar) as customer_id,
    cast(null as varchar) as status,
    cast(null as varchar) as segment,
    cast(null as varchar) as cohort_month,
    cast(null as varchar) as acquisition_channel,
    cast(null as varchar) as product_name,
    cast(null as varchar) as channel,
    cast(null as varchar) as product_category,
    cast(null as double ) as order_amount,
    cast(null as double ) as discount_amount,
    cast(null as double ) as returned_amount,
    cast(null as double ) as revenue,
    cast(null as double ) as unit_cost,
    cast(null as double ) as quantity_sold,
    cast(null as boolean) as is_refunded,
    cast(null as double ) as customer_order_number,
    cast(null as boolean) as is_repeat_order,
    cast(null as boolean) as customer_is_multi_category
where false
