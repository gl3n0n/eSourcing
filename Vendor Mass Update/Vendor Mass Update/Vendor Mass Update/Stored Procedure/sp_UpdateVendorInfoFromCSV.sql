USE [ebid]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateVendorInfoFromCsv]    Script Date: 06/05/2013 15:44:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_UpdateVendorInfoFromCsv]

(
@VendorId int,
@VendorName nvarchar(100),
@VendorCode nvarchar(10),
@Accredited int,
@VendorEmail nvarchar(100),
@MobileNo nvarchar(50),
@VendorAddress nvarchar(200),
@VendorAddress1 nvarchar(200),
@VendorAddress2 nvarchar(200),
@VendorAddress3 nvarchar(200),
@Classification int,
@AccredDate datetime,
@ContactPerson nvarchar(50),
@SalesPersonTelNo nvarchar(20),
@VendorCategory nvarchar(7),
@VendorSubCategory nvarchar(20),
@Syskey nvarchar(5),
@TelephoneNo nvarchar(20),
@Fax nvarchar(20),
@Extension nvarchar(20),
@BranchTelephoneNo nvarchar(20),
@BranchFax nvarchar(20),
@BranchExtension nvarchar(20),
@VatRegNo nvarchar(50),
@TIN nvarchar(50),
@POBox nvarchar(50),
@TermsofPayment nvarchar(100),
@SpecialTerms nvarchar(100),
@MinOrderValue float,
@PostalCode nvarchar(20),
@OwnershipFilipino int,
@OwnershipOther int,
@OrgTypeID int,
@Specialization nvarchar(50),
@SoleSupplier1 nvarchar(200),
@SoleSupplier2 nvarchar(200),
@KeyPersonnel nvarchar(100),
@KpPosition nvarchar(100),
@ISOStandard nvarchar(4),
@PCABClass int,
@IsBlackListed smallint,
@Vendor_Code nvarchar(60),
@SLA_SIR_Date datetime,
@SLA_Date_Approved datetime,
@Accreditation_Duration datetime,
@Accreditation_From datetime,
@Accreditation_To datetime,
@Perf_Evaluation_Date datetime,
@Perf_Evaluation_Rate int,
@Perf_Evaluation_Service int,
@Composite_Rating_SIR_Date datetime,
@Composite_Rating_Rate int,
@Maximum_Exposure_SIR_Date datetime,
@Maximum_Exposure_Amount float,
@Enrollment_Date datetime,
@IR_Date datetime,
@IR_Number int,
@IR_Description nvarchar(60),
@Issue_Status int
)	

AS

DECLARE @ERR INT

-- UPDATE VENDOR
IF EXISTS (SELECT [VendorId] FROM tblVendors WHERE VendorId = @VendorId)

	UPDATE [tblVendors] SET

	[VendorName] = CASE WHEN @VendorName != '' THEN @VendorName ELSE [VendorName] END,
	[VendorCode] = CASE WHEN  @VendorCode != '' THEN @VendorCode ELSE [VendorCode] END,
	[Accredited] = CASE WHEN  @Accredited != '' THEN @Accredited ELSE [Accredited] END,
	[VendorEmail] = CASE WHEN  @VendorEmail != '' THEN @VendorEmail ELSE [VendorEmail] END,
	[MobileNo] = CASE WHEN  @MobileNo != '' THEN @MobileNo ELSE [MobileNo] END,
	[VendorAddress] = CASE WHEN  @VendorAddress != '' THEN @VendorAddress ELSE [VendorAddress] END,
	[VendorAddress1] = CASE WHEN  @VendorAddress1 != '' THEN @VendorAddress1 ELSE [VendorAddress1] END,
	[VendorAddress2] = CASE WHEN  @VendorAddress2 != '' THEN @VendorAddress2 ELSE [VendorAddress2] END,
	[VendorAddress3] = CASE WHEN  @VendorAddress3 != '' THEN @VendorAddress3 ELSE [VendorAddress3] END,
	[Classification] = CASE WHEN  @Classification != '' THEN @Classification ELSE [Classification] END,
	[AccredDate] = CASE WHEN  @AccredDate != '' THEN @AccredDate ELSE [AccredDate] END,
	[ContactPerson] = CASE WHEN  @ContactPerson != '' THEN @ContactPerson ELSE [ContactPerson] END,
	[SalesPersonTelNo] = CASE WHEN  @SalesPersonTelNo != '' THEN @SalesPersonTelNo ELSE [SalesPersonTelNo] END,
	[VendorCategory] = CASE WHEN  @VendorCategory != '' THEN @VendorCategory ELSE [VendorCategory] END,
	[VendorSubCategory] = CASE WHEN  @VendorSubCategory != '' THEN @VendorSubCategory ELSE [VendorSubCategory] END,
	[Syskey] = CASE WHEN  @SysKey != '' THEN @SysKey ELSE [Syskey] END,
	[TelephoneNo] = CASE WHEN  @TelephoneNo != '' THEN @TelephoneNo ELSE [TelephoneNo] END,
	[Fax] = CASE WHEN  @Fax != '' THEN @Fax ELSE [Fax] END,
	[Extension] = CASE WHEN  @Extension != '' THEN @Extension ELSE [Extension] END,
	[BranchTelephoneNo] = CASE WHEN  @BranchTelephoneNo != '' THEN @BranchTelephoneNo ELSE [BranchTelephoneNo] END,
	[BranchFax] = CASE WHEN  @BranchFax != '' THEN @BranchFax ELSE [BranchFax] END,
	[BranchExtension] = CASE WHEN  @BranchExtension != '' THEN @BranchExtension ELSE [BranchExtension] END,
	[VatRegNo] = CASE WHEN  @VatRegNo != '' THEN @VatRegNo ELSE [VatRegNo] END,
	[TIN] = CASE WHEN  @TIN != '' THEN @TIN ELSE [TIN] END,
	[POBox] = CASE WHEN  @POBox != '' THEN @POBox ELSE [POBox] END,
	[TermsofPayment] = CASE WHEN  @TermsofPayment != '' THEN @TermsofPayment ELSE [TermsofPayment] END,
	[SpecialTerms] = CASE WHEN  @SpecialTerms != '' THEN @SpecialTerms ELSE [SpecialTerms] END,
	[MinOrderValue] = CASE WHEN  @MinOrderValue != '' THEN @MinOrderValue ELSE [MinOrderValue] END,
	[PostalCode] = CASE WHEN  @PostalCode != '' THEN @PostalCode ELSE [PostalCode] END,
	[OwnershipFilipino] = CASE WHEN  @OwnershipFilipino != '' THEN @OwnershipFilipino ELSE [OwnershipFilipino] END,
	[OwnershipOther] = CASE WHEN  @OwnershipOther != '' THEN @OwnershipOther ELSE [OwnershipOther] END,
	[OrgTypeID] = CASE WHEN  @OrgTypeID != '' THEN @OrgTypeID ELSE [OrgTypeID] END,
	[Specialization] = CASE WHEN  @Specialization != '' THEN @Specialization ELSE [Specialization] END,
	[SoleSupplier1] = CASE WHEN  @SoleSupplier1 != '' THEN @SoleSupplier1 ELSE [SoleSupplier1] END,
	[SoleSupplier2] = CASE WHEN  @SoleSupplier2 != '' THEN @SoleSupplier2 ELSE [SoleSupplier2] END,
	[KeyPersonnel] = CASE WHEN  @KeyPersonnel != '' THEN @KeyPersonnel ELSE [KeyPersonnel] END,
	[KpPosition] = CASE WHEN  @KpPosition != '' THEN @KpPosition ELSE [KpPosition] END,
	[ISOStandard] = CASE WHEN  @ISOStandard != '' THEN @ISOStandard ELSE [ISOStandard] END,
	[PCABClass] = CASE WHEN  @PCABClass != '' THEN @PCABClass ELSE [PCABClass] END,
	[IsBlackListed] = CASE WHEN  @IsBlackListed != '' THEN @IsBlacklisted ELSE [IsBlackListed] END,
	[Vendor_Code] = CASE WHEN  @VendorCode != '' THEN @VendorCode ELSE [VendorCode] END,
	[SLA_SIR_Date] = CASE WHEN  @SLA_SIR_Date != '' THEN @SLA_SIR_Date ELSE [SLA_SIR_Date] END,
	[SLA_Date_Approved] = CASE WHEN  @SLA_Date_Approved != '' THEN @SLA_Date_Approved ELSE [SLA_Date_Approved] END,
	[Accreditation_Duration] = CASE WHEN  @Accreditation_Duration != '' THEN @Accreditation_Duration ELSE [Accreditation_Duration] END,
	[Accreditation_From] = CASE WHEN  @Accreditation_From != '' THEN @Accreditation_From ELSE [Accreditation_From] END,
	[Accreditation_To] = CASE WHEN  @Accreditation_To != '' THEN @Accreditation_To ELSE [Accreditation_To] END,
	[Perf_Evaluation_Date] = CASE WHEN  @Perf_Evaluation_Date != '' THEN @Perf_Evaluation_Date ELSE [Perf_Evaluation_Date] END,
	[Perf_Evaluation_Rate] = CASE WHEN  @Perf_Evaluation_Rate != '' THEN @Perf_Evaluation_Rate ELSE [Perf_Evaluation_Rate] END,
	[Perf_Evaluation_Service] = CASE WHEN  @Perf_Evaluation_Service != '' THEN @Perf_Evaluation_Service ELSE [Perf_Evaluation_Service] END,
	[Composite_Rating_SIR_Date] = CASE WHEN  @Composite_Rating_SIR_Date != '' THEN @Composite_Rating_SIR_Date ELSE [Composite_Rating_SIR_Date] END,
	[Composite_Rating_Rate] = CASE WHEN  @Composite_Rating_Rate != '' THEN @Composite_Rating_Rate ELSE [Composite_Rating_Rate] END,
	[Maximum_Exposure_SIR_Date] = CASE WHEN  @Maximum_Exposure_SIR_Date != '' THEN @Maximum_Exposure_SIR_Date ELSE [Maximum_Exposure_SIR_Date] END,
	[Maximum_Exposure_Amount] = CASE WHEN  @Maximum_Exposure_Amount != '' THEN @Maximum_Exposure_Amount ELSE [Maximum_Exposure_Amount] END,
	[Enrollment_Date] = CASE WHEN  @Enrollment_Date != '' THEN @Enrollment_Date ELSE [Enrollment_Date] END,
	[IR_Date] = CASE WHEN  @IR_Date != '' THEN @IR_Date ELSE [IR_Date] END,
	[IR_Number] = CASE WHEN  @IR_Number != '' THEN @IR_Number ELSE [IR_Number] END,
	[IR_Description] = CASE WHEN  @IR_Description != '' THEN @IR_Description ELSE [IR_Description] END,
	[Issue_Status] = CASE WHEN  @Issue_Status != '' THEN @Issue_Status ELSE [Issue_Status] END

	WHERE [VendorId] = @VendorId

SET @ERR=@@ERROR
RETURN @ERR



