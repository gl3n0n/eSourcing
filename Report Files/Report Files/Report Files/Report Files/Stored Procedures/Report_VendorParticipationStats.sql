USE [ebid]
GO
/****** Object:  StoredProcedure [dbo].[sp_Report_VendorParticipationStats]    Script Date: 05/06/2013 15:03:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[sp_Report_VendorParticipationStats]
(
@BuyerId varchar(10),
@StartDate datetime,
@EndDate datetime
)
AS


SELECT I.VendorName,
	(CASE
		WHEN A.Status = 2 THEN 'Rejected'
		WHEN A.Status = 4 THEN
		(CASE 
			WHEN B.WithdrawalStatus = 4 THEN 'WithDrawn'
			ELSE 
			(CASE 
				WHEN H.Status = 4 THEN 'Awarded'
				ELSE 'Not Awarded'
			END)			
		END)
	END) as BidStatus,
	(CASE
		WHEN C.Status = 0 THEN 'Invited'
		WHEN C.Status = 2 THEN 'Declined'
		WHEN C.Status = 1 THEN 
		(CASE
			WHEN C.VendorId = H.VendorId THEN 'Participated'
			ELSE 'Accepted'
		END)
	END) as ParticipationStatus, E.CategoryName,
			(CASE
				WHEN A.SubCategory IS NULL THEN NULL 
				ELSE
					(select SubCategoryName from rfcProductSubCategory where SubCategoryId = A.SubCategory)
			END) as SubCategory, A.Currency, J.BuyerLastName + ', ' + J.BuyerFirstName + ' ' + J.BuyerMidName as BuyerName, G.LastName + ', ' +
			G.FirstName + ' ' + G.MiddleName as ProcurementOfficer, C.DateInvited, C.DateConfirmed, C.DateDeclined, A.DateApproved, A.DateRejected, B.DateWithdrawned
	
FROM tblBidItems A
INNER JOIN tblBidItemDetails B ON A.BidRefNo = B.BidReFNo
INNER JOIN tblVendorsInBids C ON A.BidRefNo = C.BidRefNo
--INNER JOIN tblBacBidItems D ON A.BidRefNo = D.BidRefNo
INNER JOIN rfcProductCategory E ON A.Category = E.CategoryId
INNER JOIN tblSupervisor F ON A.BuyerId = F.BuyerId
INNER JOIN tblPurchasing G ON F.PurchasingId = G.PurchasingId
INNER JOIN tblBidTenders H ON B.BidDetailNo = H.BidDetailNo
INNER JOIN tblVendors I ON C.VendorId = I.VendorId
INNER JOIN tblBuyers J ON A.BuyerId = J.BuyerId 

WHERE (A.Status = 2 OR A.Status = 4)
AND A.BuyerId like ISNULL(@BuyerId,'%') -- Buyer ID
AND E.CategoryName not like 'do not use%' -- Filters out invalid Product Category
AND ( A.DateApproved between ISNULL(@StartDate, '1901-01-01 00:00:00') and ISNULL(@EndDate,'2100-01-01 00:00:00')) -- From and To Date 


ORDER BY VendorName, BidStatus
