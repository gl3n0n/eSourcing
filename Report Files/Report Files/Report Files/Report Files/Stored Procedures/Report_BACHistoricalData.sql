USE [ebid]
GO
/****** Object:  StoredProcedure [dbo].[sp_Report_BACHistoricalData]    Script Date: 05/06/2013 15:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[sp_Report_BACHistoricalData]
(
@BuyerId varchar(10),
@StartDate datetime,
@EndDate datetime
)
AS


SELECT (CASE 
			WHEN A.ClarifyDt_0 IS NOT NULL THEN 'Clarified'
			WHEN A.ApprovedDt_0 IS NOT NULL THEN 'Approved'
			WHEN A.ApprovedDt_0 IS NULL THEN 'Rejected'
			--WHEN B.Status = 2 THEN 'Rejected'
			--ELSE cast(A.Status as varchar)
		END) AS Status, 
		D.VendorName, 
		E.BuyerLastName + ', ' + E.BuyerFirstName + ' ' + E.BuyerMidName as BuyerName, 
		J.LastName + ', ' + J.FirstName + ' ' + J.MiddleName as ProcurementOfficer, 
		H.SourcingStrategy, 
		I.SupplyPosition,
		(CASE 
			WHEN A.ClarifyDt_0 IS NOT NULL THEN A.ClarifyDt_0
			WHEN A.ClarifyDt_1 IS NOT NULL THEN A.ClarifyDt_1
			WHEN A.ClarifyDt_2 IS NOT NULL THEN A.ClarifyDt_2
			WHEN A.ClarifyDt_3 IS NOT NULL THEN A.ClarifyDt_3
			WHEN A.ClarifyDt_4 IS NOT NULL THEN A.ClarifyDt_4
			WHEN A.ClarifyDt_5 IS NOT NULL THEN A.ClarifyDt_5
			WHEN A.ClarifyDt_6 IS NOT NULL THEN A.ClarifyDt_6
			WHEN A.ClarifyDt_7 IS NOT NULL THEN A.ClarifyDt_7
			WHEN A.ClarifyDt_8 IS NOT NULL THEN A.ClarifyDt_8
			WHEN A.ClarifyDt_9 IS NOT NULL THEN A.ClarifyDt_9
			WHEN A.ClarifyDt_10 IS NOT NULL THEN A.ClarifyDt_10
		END) AS ClarifyDate, 
		CONVERT(nvarchar(30),cast(A.BidAmount as money), 1) as Amount, 
		B.ItemDesc, 
		CASE WHEN A.Approver_0 IS NOT NULL THEN (SELECT G.LastName + ', ' + G.FirstName + ' ' + G.MiddleName WHERE G.BACId = A.Approver_0) ELSE NULL END AS Approver0, A.ApprovedDt_0,
		CASE WHEN A.Approver_1 IS NOT NULL THEN (SELECT G.LastName + ', ' + G.FirstName + ' ' + G.MiddleName WHERE G.BACId = A.Approver_1) ELSE NULL END AS Approver1, A.ApprovedDt_1,
		CASE WHEN A.Approver_2 IS NOT NULL THEN (SELECT G.LastName + ', ' + G.FirstName + ' ' + G.MiddleName WHERE G.BACId = A.Approver_2) ELSE NULL END AS Approver2, A.ApprovedDt_2,
		CASE WHEN A.Approver_3 IS NOT NULL THEN (SELECT G.LastName + ', ' + G.FirstName + ' ' + G.MiddleName WHERE G.BACId = A.Approver_3) ELSE NULL END AS Approver3, A.ApprovedDt_3,
		CASE WHEN A.Approver_4 IS NOT NULL THEN (SELECT G.LastName + ', ' + G.FirstName + ' ' + G.MiddleName WHERE G.BACId = A.Approver_4) ELSE NULL END AS Approver4, A.ApprovedDt_4,
		CASE WHEN A.Approver_5 IS NOT NULL THEN (SELECT G.LastName + ', ' + G.FirstName + ' ' + G.MiddleName WHERE G.BACId = A.Approver_5) ELSE NULL END AS Approver5, A.ApprovedDt_5,
		CASE WHEN A.Approver_6 IS NOT NULL THEN (SELECT G.LastName + ', ' + G.FirstName + ' ' + G.MiddleName WHERE G.BACId = A.Approver_6) ELSE NULL END AS Approver6, A.ApprovedDt_6,
		CASE WHEN A.Approver_7 IS NOT NULL THEN (SELECT G.LastName + ', ' + G.FirstName + ' ' + G.MiddleName WHERE G.BACId = A.Approver_7) ELSE NULL END AS Approver7, A.ApprovedDt_7,
		CASE WHEN A.Approver_8 IS NOT NULL THEN (SELECT G.LastName + ', ' + G.FirstName + ' ' + G.MiddleName WHERE G.BACId = A.Approver_8) ELSE NULL END AS Approver8, A.ApprovedDt_8,
		CASE WHEN A.Approver_9 IS NOT NULL THEN (SELECT G.LastName + ', ' + G.FirstName + ' ' + G.MiddleName WHERE G.BACId = A.Approver_9) ELSE NULL END AS Approver9, A.ApprovedDt_9

FROM tblBacBidItems A
	INNER JOIN tblBidItems B ON B.BidRefNo = A.BidRefNo
	INNER JOIN tblVendorsInBids C ON B.BidRefNo = C.BidRefNo
	INNER JOIN tblVendors D ON C.VendorId = D.VendorId
	INNER JOIN tblBuyers E ON B.BuyerId = E.BuyerId
	INNER JOIN tblSupervisor F ON B.BuyerId = F.BuyerId
	INNER JOIN tblBidAwardingCommittee G ON A.Approver_0 = G.BACId OR A.Approver_1 = G.BACId OR A.Approver_2 = G.BACId OR A.Approver_3 = G.BACId OR A.Approver_4 = G.BACId OR A.Approver_5 = G.BACId OR A.Approver_6 = G.BACId OR A.Approver_7 = G.BACId OR A.Approver_8 = G.BACId OR A.Approver_9 = G.BACId
	INNER JOIN tblBACSourcingStrategy H ON B.BidRefNo = H.BidRefNo
	INNER JOIN tblBACSupplyPosition I ON B.BidRefNo = I.BidRefNo
	INNER JOIN tblPurchasing J ON F.PurchasingId = J.PurchasingId

WHERE A.BuyerId like ISNULL(@BuyerId,'%') -- Buyer ID
	AND ( A.RcvdDate between ISNULL(@StartDate, '1901-01-01 00:00:00') and ISNULL(@EndDate,'2100-01-01 00:00:00')) -- From and To Date 


ORDER BY Status





