USE [ebid]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllBuyerNames]    Script Date: 04/03/2013 18:46:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_GetAllBuyerNames]

AS

SELECT	BuyerId, BuyerFirstName + ' ' + BuyerMidName + ' ' + BuyerLastName as BuyerName
FROM	tblBuyers
ORDER BY [BuyerName]
