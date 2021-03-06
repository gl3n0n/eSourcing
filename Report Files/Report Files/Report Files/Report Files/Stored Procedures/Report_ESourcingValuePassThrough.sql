USE [ebid]
GO
/****** Object:  StoredProcedure [dbo].[sp_Report_ESourcingValuePassThrough]    Script Date: 05/06/2013 15:05:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[sp_Report_ESourcingValuePassThrough]
(
@BuyerId varchar(10),
@StartDate datetime,
@EndDate datetime
)
AS

SELECT (CASE 
			WHEN B.WithDrawalStatus = 4 THEN 'Withdrawn'
			WHEN B.WithDrawalStatus = 0 THEN 
			(CASE
				WHEN H.Status = 0 THEN 'Draft'
   				WHEN H.Status = 1 THEN 'Submitted'
   				WHEN H.Status = 2 THEN 'Rejected'
   				WHEN H.Status = 3 THEN 'Re-Edit'
   				WHEN H.Status = 4 THEN 'Awarded' 
   				WHEN H.Status = 5 THEN 'Not Awarded'
   					ELSE cast(A.Status as varchar)
   			END)END) as Status, D.VendorName, E.BuyerLastName + ', ' + E.BuyerFirstName + ' ' + E.BuyerMidName as BuyerName, G.LastName + ', ' + 
			G.FirstName + ' ' + G.MiddleName as ProcurementOfficer, I.CategoryName,
			(CASE
				WHEN A.SubCategory IS NULL THEN NULL 
				ELSE
					(select SubCategoryName from rfcProductSubCategory where SubCategoryId = A.SubCategory)
			END) as SubCategory, A.DateApproved, A.DateSavedAsDraft, A.DateSubmitted, A.DateRejected, H.DateAwarded, CONVERT(nvarchar(30),cast(H.Amount as money), 1) as Amount, A.ItemDesc 

FROM	tblBidItems A
		INNER JOIN tblBidItemDetails B ON A.BidRefNo = B.BIdRefNo
		INNER JOIN tblVendorsInBids C ON B.BidRefNo = C.BidRefNo
		INNER JOIN tblVendors D ON C.VendorId = D.VendorId
		INNER JOIN tblBuyers E ON A.BuyerId = E.BuyerId
		INNER JOIN tblSupervisor F ON A.BuyerId = F.BuyerId
		INNER JOIN tblPurchasing G ON F.PurchasingId = G.PurchasingId
		INNER JOIN tblBidTenders H ON B.BidDetailNo = H.BidDetailNo
		INNER JOIN rfcProductCategory I on A.Category = I.CategoryID

WHERE A.BuyerId like ISNULL(@BuyerId,'%') -- Buyer ID
	AND I.CategoryName not like 'do not use%' -- Filters out invalid Product Category
	AND ( A.DateApproved between ISNULL(@StartDate, '1901-01-01 00:00:00') and ISNULL(@EndDate,'2100-01-01 00:00:00')) -- From and To Date 

ORDER BY D.VendorName, Status