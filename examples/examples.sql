/*
What is the most popular media type among all the tracks?
*/
SELECT 
    MediaType.Name AS media_type,
    COUNT(Track.TrackId) AS track_count
FROM Track
    INNER JOIN 
        MediaType ON MediaType.MediaTypeId = Track.MediaTypeId
GROUP BY Track.MediaTypeId
ORDER BY track_count DESC
LIMIT 5;

/*
What is the total price for the album 'Big Ones'?
*/
SELECT 
    Album.Title AS album_title,
    SUM(Track.UnitPrice) AS album_price
FROM
    Track
    INNER JOIN
        Album ON Album.AlbumId = Track.AlbumId
WHERE
    Album.Title = 'Big Ones'
GROUP BY
    Track.AlbumId;

/*
Which tracks made the most in total sales?
*/
SELECT 
    Track.Name AS track_name, 
    SUM(
        InvoiceLine.Quantity * InvoiceLine.UnitPrice
    ) AS total_sales
FROM
    InvoiceLine
    INNER JOIN
        Track ON InvoiceLine.TrackId = Track.TrackId
GROUP BY 
    InvoiceLine.TrackId
ORDER BY 
    total_sales DESC
LIMIT 5;

/*
Which tracks sold the most number of units?
*/
SELECT     
    Track.Name,
    SUM(InvoiceLine.Quantity) AS total_quantity
FROM
    InvoiceLine
    INNER JOIN
        Track ON Track.TrackId = InvoiceLine.TrackId
GROUP BY
    InvoiceLine.TrackId
ORDER BY
    total_quantity DESC
LIMIT 5;

/*
What was the most purchased tracks of 2022?
*/
SELECT 
    InvoiceLine.TrackId AS track_id,
    Track.Name AS track_name,
    strftime('%Y', Invoice.InvoiceDate) AS invoice_year,
    SUM(InvoiceLine.Quantity) AS total_quantity
FROM
    InvoiceLine
    INNER JOIN
        Invoice ON Invoice.InvoiceId = InvoiceLine.InvoiceId
    INNER JOIN
        Track ON Track.TrackId = InvoiceLine.TrackId
WHERE
    invoice_year = '2022'
GROUP BY
    InvoiceLine.TrackId
ORDER BY
    total_quantity DESC
LIMIT 5;

/*
How many albums does 'Iron Maiden' have?
*/
SELECT 
    Artist.Name AS artist_name,
    COUNT(Album.AlbumId) AS album_count
FROM
    Album
    INNER JOIN
        Artist ON Artist.ArtistId = Album.ArtistId
WHERE
    Artist.Name = 'Iron Maiden'
GROUP BY
    Album.ArtistId;

/*
Find all albums for the artist 'AC/DC'.
*/
SELECT 
	Album.Title AS album_title,
	Artist.Name AS artist_name
FROM 
	Album 
	INNER JOIN
		Artist ON Artist.ArtistId = Album.ArtistId
WHERE 
	Artist.Name = 'AC/DC';

/*
List all the tracks in the album with title 'Let There Be Rock'.
*/
SELECT Track.Name
FROM Track
WHERE Track.AlbumId = (
   SELECT Album.AlbumId
   FROM Album
   WHERE Album.Title = 'Let There Be Rock'
);

/*
How many tracks are there in the album 'Big Ones'?
*/
SELECT 
	Album.Title AS album_title,
	COUNT(Track.TrackId) AS track_count
FROM 
	Track
	INNER JOIN
		Album ON Album.AlbumId = Track.AlbumId
WHERE 
    Album.Title = 'Big Ones';

/*
List 10 tracks in the 'Rock' genre.
*/
SELECT 
    Track.Name
FROM Track
    INNER JOIN 
        Genre ON Genre.GenreId = Track.GenreId
WHERE 
    Genre.Name = 'Rock' 
LIMIT 10;

/*
Which tracks are added to the most number of playlists?
*/
SELECT 
    Track.Name AS track_name,
    COUNT(Track.TrackId) AS track_count
FROM 
    PlaylistTrack
    INNER JOIN
        Playlist ON Playlist.PlaylistId = PlaylistTrack.PlaylistId
    INNER JOIN
        Track ON Track.TrackId = PlaylistTrack.TrackId
GROUP BY
    Track.TrackId
ORDER BY
    track_count DESC
LIMIT 5;

/*
List all customers from Canada.
*/
SELECT 
    CONCAT(
        Customer.FirstName, ' ', Customer.LastName
    ) AS full_name
FROM 
    Customer 
WHERE 
    Customer.Country = 'Canada';

/*
Which country's customers spent the most?
*/
SELECT 
    Customer.Country,
    SUM(Invoice.Total) AS total_spent
FROM
    Invoice
    INNER JOIN
        Customer ON Customer.CustomerId = Invoice.CustomerId
GROUP BY
    Customer.Country
ORDER BY
    total_spent DESC
LIMIT 5;

/*
Who are the top 5 customers by total purchase?
*/
SELECT 
    CONCAT(
        Customer.FirstName, ' ', Customer.LastName
    ) AS full_name,
    Customer.Country,
    SUM(Invoice.Total) AS total_purchase
FROM
    Invoice
    INNER JOIN
        Customer ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Invoice.CustomerId
ORDER BY total_purchase DESC
LIMIT 5;

/*
Which employees made the most in sales?
*/
SELECT 
    CONCAT(
        Employee.FirstName, ' ', Employee.LastName
    ) AS full_name,
    Employee.Title AS job_title,
    SUM(Invoice.Total) AS total_sales_made
FROM
    Employee
    INNER JOIN
        Customer ON Customer.SupportRepId = Employee.EmployeeId
    INNER JOIN
        Invoice ON Invoice.CustomerId = Customer.CustomerId
GROUP BY
    Employee.EmployeeId
ORDER BY
    total_sales_made DESC
LIMIT 5;

/*
Which employee made the most in sales in the year 2021?
*/
SELECT 
    CONCAT(
        Employee.FirstName, ' ', Employee.LastName
    ) AS full_name,
    Employee.Title AS job_title,
    strftime('%Y', Invoice.InvoiceDate) AS invoice_year,
    SUM(Invoice.Total) AS total_sales_made
FROM
    Employee
    INNER JOIN
        Customer ON Customer.SupportRepId = Employee.EmployeeId
    INNER JOIN
        Invoice ON Invoice.CustomerId = Customer.CustomerId
WHERE 
    invoice_year = '2021'
GROUP BY
    Employee.EmployeeId
ORDER BY
    total_sales_made DESC
LIMIT 5;

/*
List all the managers and their direct report.
*/
SELECT 
	M.FirstName || ' ' || M.LastName AS manager,
	M.Title AS manager_title,
	E.FirstName || ' ' || E.LastName AS direct_report,
	E.Title AS employee_title
FROM 
	Employee AS E
	INNER JOIN 
		Employee AS M ON M.EmployeeId = E.ReportsTo
ORDER BY 
	manager ASC;

/*
Who directly reports to the General Manager?
*/
SELECT 
	M.FirstName || ' ' || M.LastName AS manager,
	M.Title AS manager_title,
	E.FirstName || ' ' || E.LastName AS direct_report,
	E.Title AS employee_title
FROM 
	Employee AS E
	INNER JOIN 
		Employee AS M ON M.EmployeeId = E.ReportsTo
WHERE
    M.Title = 'General Manager';

/*
Which employees work in the city Calgary?
*/
SELECT
	Employee.FirstName || ' ' || Employee.LastName 
        AS full_name,
	Employee.City,
	Employee.Title
FROM
	Employee
WHERE
	Employee.City = 'Calgary';