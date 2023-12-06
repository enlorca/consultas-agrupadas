SELECT * FROM INSCRITOS;

-- Inicio ■ Asumiendo que el formato de fecha es mes-dia-año.
-- 1. ¿Cuántos registros hay? usar alias para el titulo de la columna

SELECT COUNT(*) AS registros_totales
FROM INSCRITOS;

-- 2. ¿Cuántos inscritos hay en total? usar alias para el titulo de la columna

SELECT SUM(cantidad) AS inscritos_totales
FROM INSCRITOS;

-- 3. ¿Cuál o cuáles son los registros de mayor antigüedad? ocupar subconsultas (no usar limit, aplicar obligatorio subconsulta)

SELECT *
FROM INSCRITOS
WHERE fecha = (SELECT MIN(fecha) FROM INSCRITOS);

-- 4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante).(EL RESULTADO DEBE SER 8 REGISTROS)

	-- Solución 1, solo los 8 registros.

SELECT SUM(cantidad) FROM INSCRITOS
GROUP BY fecha;

	-- Solución 2, con una columna indicando de que día es cada registro para facilitar su lectura.

SELECT fecha, SUM(cantidad) AS inscripciones_del_dia
FROM INSCRITOS
GROUP BY fecha
ORDER BY fecha;

-- 5. ¿Cuántos inscritos hay por fuente?

SELECT fuente, SUM(cantidad) AS inscripciones_totales
FROM INSCRITOS
GROUP BY fuente;

-- 6. ¿Qué día se inscribió la mayor cantidad de personas? Y ¿Cuántas personas se inscribieron en ese día? 

SELECT fecha, SUM(cantidad) AS inscripciones_totales
FROM INSCRITOS
GROUP BY fecha
HAVING SUM(cantidad) = (SELECT MAX(inscripciones_totales) FROM (SELECT fecha, SUM(cantidad) AS inscripciones_totales FROM INSCRITOS GROUP BY fecha) AS subquery);

-- 7. ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas personas fueron?

SELECT fecha, SUM(cantidad) AS inscripciones_blog
FROM INSCRITOS
WHERE fuente = 'Blog'
GROUP BY fecha
ORDER BY inscripciones_blog DESC
LIMIT 1;

-- 8. ¿Cuál es el promedio de personas inscritas por día?

SELECT AVG(inscripciones_totales) AS inscripciones_promedio
FROM (
    SELECT fecha, SUM(cantidad) AS inscripciones_totales
    FROM INSCRITOS
    GROUP BY fecha
) AS subquery;

-- 9. ¿Qué días se inscribieron más de 50 personas?

SELECT fecha
FROM INSCRITOS
GROUP BY fecha
HAVING SUM(cantidad) > 50;

-- 10. ¿Cuál es el promedio diario de personas inscritas a partir del tercer día en adelante, considerando únicamente las fechas posteriores o iguales a la indicada?

SELECT
  fecha,
  ROUND(AVG(cantidad),2) AS inscripciones_promedio
FROM INSCRITOS
WHERE fecha >= '2021-03-01'
GROUP BY fecha
ORDER BY fecha;


