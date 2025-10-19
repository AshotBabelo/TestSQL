-- 2.1. Получение информации о сумме товаров заказанных под каждого клиента
-- (Наименование клиента, общая сумма заказов)
SELECT
    c.name AS client_name,
    COALESCE(SUM(p.price * oi.quantity), 0) AS total_sum
FROM
    clients c
LEFT JOIN orders o ON c.id = o.client_id
LEFT JOIN order_items oi ON o.id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.id
GROUP BY
    c.id, c.name
ORDER BY
    total_sum DESC;


-- 2.2. Количество дочерних элементов первого уровня вложенности для каждой категории
SELECT
    parent.name AS category_name,
    COUNT(child.id) AS direct_children_count
FROM
    categories parent
LEFT JOIN categories child ON parent.id = child.parent_id
GROUP BY
    parent.id, parent.name
ORDER BY
    parent.id;