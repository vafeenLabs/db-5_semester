SELECT
    name
FROM
    Ships
    JOIN Classes ON Ships.class = Classes.class
WHERE
    (
        numguns >= 9
        OR numguns IS NULL
    )
    AND (
        bore < 19
        OR bore IS NULL
    )
    AND (
        displacement <= 65000
        OR displacement IS NULL
    )
    AND (
        type = 'bb'
        OR type IS NULL
    )
    AND (
        country = 'Japan'
        OR country IS NULL
    );