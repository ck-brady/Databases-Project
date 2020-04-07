CREATE VIEW GuestListView AS
SELECT Account_ID, First_Name, Middle_Name, Last_Name, address, Email, Phone_Number
FROM Person 
WHERE EXISTS (SELECT    1
              FROM      Guest
              WHERE     Guest.Account_ID = Person.Account_ID)
ORDER BY Account_ID ASC;


SELECT a.Listing_ID, b.Overall_Score
FROM Rental_Agreement a JOIN Reviews b ON a.RA_ID = b.RA_ID
ORDER BY Overall_Score ASC;



SELECT * 
FROM Listing
WHERE EXISTS (SELECT 1
              FROM Rental_Agreement
              WHERE Rental_Agreement.RA_ID = Listing.RA_ID AND Rental_Agreement.Signing_Date = 10)
            


SELECT * 
FROM pricing
WHERE EXISTS (SELECT 1
              FROM Property
              WHERE property.Property_ID = pricing.Property_ID
              and EXISTS (
                    SELECT 1
                    FROM Listing
                    WHERE Listing.Property_ID = Property.Property_ID
                    AND EXISTS (
                        SELECT 1
                        FROM Rental_Agreement
                        WHERE listing.listing_ID = rental_agreement.listing_ID 
                        and EXISTS(
                            SELECT 1
                            FROM Rental_Agreement
                            WHERE Rental_Agreement.Guest_ID = 123 
                        )
                    )

              )
              )



SELECT  
    FirstName, 
    MiddleName, 
    LastName,
    CONCAT(FirstName,' ',MiddleName,' ',LastName) as full_name
FROM Person