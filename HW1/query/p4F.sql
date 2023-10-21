WITH quantity AS (
    SELECT c.name AS color_name, ip.inventory_id, SUM(ip.quantity) AS quantity_sum, ip.part_num
    FROM inventory_parts ip
    JOIN colors c ON c.id = ip.color_id
    GROUP BY c.name, ip.inventory_id, ip.part_num
),total_quantity AS (
    SELECT
        t.name AS theme_name,
        q.color_name,
        SUM(q.quantity_sum) AS total_quantity,
        RANK() OVER (PARTITION BY t.name ORDER BY SUM(q.quantity_sum) DESC) AS rank
    FROM
        themes t
        JOIN sets s ON t.id = s.theme_id
        JOIN inventories i ON s.set_num = i.set_num
        JOIN quantity q ON i.id = q.inventory_id
    GROUP BY
        t.name,
        q.color_name
)
SELECT
    theme_name,
    color_name AS most_used_color
FROM
    total_quantity
WHERE
    rank = 1;
