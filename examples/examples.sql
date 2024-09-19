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
LIMIT 3;

/*
What is the total price for the album "Big Ones"?
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
What is the best-selling track of all time?
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
Top 5 best-selling tracks by number of units sold.
*/
SELECT 
    InvoiceLine.TrackId,
    Track.Name,
    SUM(InvoiceLine.Quantity) as total_quantity
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
What was the most purchased tracks of 2013?
*/
SELECT 
    InvoiceLine.TrackId as track_id,
    Track.Name as track_name,
    strftime('%Y', Invoice.InvoiceDate) as invoice_year,
    SUM(InvoiceLine.Quantity) AS total_quantity
FROM
    InvoiceLine
    INNER JOIN
        Invoice ON Invoice.InvoiceId = InvoiceLine.InvoiceId
    INNER JOIN
        Track ON Track.TrackId = InvoiceLine.TrackId
WHERE
    invoice_year = '2013'
GROUP BY
    InvoiceLine.TrackId
ORDER BY
    total_sales DESC
LIMIT 5;

/*
How many albums does "Iron Maiden" have?
*/
SELECT 
    Artist.Name as artist_name,
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
SELECT Album.Title 
FROM Album 
WHERE Album.ArtistId = (
    SELECT Artist.ArtistId 
    FROM Artist 
    WHERE Artist.Name = 'AC/DC'
);

/*
List all the tracks in the album with title "Let There Be Rock".
*/
SELECT Track.Name
FROM Track
WHERE Track.AlbumId = (
   SELECT Album.AlbumId
   FROM Album
   WHERE Album.Title = 'Let There Be Rock'
);

/*
How many tracks are there in the album "Big Ones"?
*/
SELECT COUNT(Track.TrackId)
FROM Track
WHERE Track.AlbumId = (
    SELECT Album.AlbumId
    FROM Album
    WHERE Album.Title = 'Big Ones'
);

/*
List 10 tracks in the 'Rock' genre.
*/
SELECT Track.Name
FROM Track
    INNER JOIN Genre ON Genre.GenreId = Track.GenreId
WHERE Genre.Name = 'Rock' 
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
SELECT CONCAT(
    Customer.FirstName, ' ', Customer.LastName
)
FROM Customer 
WHERE Customer.Country = 'Canada';

/*
Which country's customers spent the most?
*/
SELECT 
    Customer.Country AS customer_country,
    SUM(Invoice.Total) AS total_spent
FROM
    Invoice
    INNER JOIN
        Customer ON Customer.CustomerId = Invoice.CustomerId
GROUP BY
    Customer.Country
ORDER BY
    total_spent DESC
LIMIT 1;

/*
Who are the top 5 customers by total purchase?
*/
SELECT 
    CONCAT(
        Customer.FirstName, ' ', Customer.LastName
    ) AS customer_name,
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
Which employee made the most in sales?
*/
SELECT 
    CONCAT(
        Employee.FirstName, ' ', Employee.LastName
    ) AS employee_name,
    Employee.Title AS job_title,
    SUM(Invoice.Total) AS total_invoice
FROM
    Employee
    INNER JOIN
        Customer ON Customer.SupportRepId = Employee.EmployeeId
    INNER JOIN
        Invoice ON Invoice.CustomerId = Customer.CustomerId
GROUP BY
    Employee.EmployeeId
ORDER BY
    total_invoice DESC
LIMIT 1;

/*
Which employee made the most in sales in the year 2009?
*/
SELECT 
    CONCAT(
        Employee.FirstName, ' ', Employee.LastName
    ) AS employee_name,
    Employee.Title AS job_title,
    strftime('%Y', Invoice.InvoiceDate) AS invoice_year,
    SUM(Invoice.Total) AS total_invoice
FROM
    Employee
    INNER JOIN
        Customer ON Customer.SupportRepId = Employee.EmployeeId
    INNER JOIN
        Invoice ON Invoice.CustomerId = Customer.CustomerId
WHERE 
    invoice_year = '2009'
GROUP BY
    Employee.EmployeeId
ORDER BY
    total_invoice DESC
LIMIT 1;

/*
How many employees are there?
*/
SELECT COUNT(Employee.EmployeeId) 
FROM Employee;