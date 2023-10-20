WITH color_use(name,num_use) AS(
	SELECT c.name,COUNT(DISTINCT ip.part_num)
	FROM inventory_parts ip,colors c
	WHERE c.id = ip.color_id
	GROUP BY c.id
)



SELECT c.name colors_name,cu.num_use
FROM colors c,color_use cu
WHERE c.name = cu.name
ORDER BY num_use DESC
LIMIT 10
