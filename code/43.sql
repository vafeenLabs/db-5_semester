SELECT
    name
FROM
    Battles
WHERE
    EXTRACT(
        YEAR
        from
            "date"
    ) NOT IN (
        SELECT
            EXTRACT(
                YEAR
                from
                    "date"
            )
        FROM
            Battles
            JOIN Ships ON EXTRACT(
                YEAR
                from
                    "date"
            ) = launched
    )