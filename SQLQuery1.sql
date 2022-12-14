/*********
We know how to find diagnoses.
ICD10SID = 1001480161
Two inpat and one outpat table, plus maybe problem list.

We know how to find IgM.
LabChemTestSID = 1000103387
*********/

--find our icd code and its sid
SELECT  *
  FROM [CDWWork].[Dim].[ICD10]
  where sta3n = 580 and (ICD10Code like 'c88%' or ICD10Code like 'c90%')
  -- c88 is waldenstrom, really c88.0
  --icd10sid 1001480161

/*
10 inpatient stays, waldenstrom, PRINCIPAL dx.
Not selecting PatientSID which is identifier.
Note, this is not [Inpat].[InpatientDiagnosis] or [Inpat].[InpatientDischargeDiagnosis]
*/
SELECT TOP (10) 
Sta3n
--[InpatientSID]
--      ,[PTFIEN]
--      ,[Sta3n]
--      ,[PatientSID]
--      ,[MeansTestIndicator]
      ,[AdmitDateTime]
      --,[AdmitVistaErrorDate]
      --,[AdmitDateTimeTransformSID]
      --,[AdmitDateSID]
      --,[AdmitSourceSID]
      --,[AdmitEligibilitySID]
      --,[TransferFromFacility]
      --,[TransferFromFacilitySuffix]
      --,[SourceOfPayment]
      --,[SuicideSelfInflict]
      --,[PsychSeverity]
      --,[PsychFunctional]
      --,[PsychHighLevel]
      --,[TransmissionStatus]
      --,[DischargeFromFacility]
      --,[DischargeFromFacilitySuffix]
      ,[DischargeDateTime]
      --,[DischargeVistaErrorDate]
      --,[DischargeDateTimeTransformSID]
      --,[DischargeDateSID]
      --,[DischargeStatus]
      --,[OutpatientReferralFlag]
      --,[DispositionType]
      --,[PlaceOfDispositionSID]
      --,[TransferToFacility]
      --,[TransferToFacilitySuffix]
      --,[ASIHDays]
      --,[CPStatus]
      --,[AbusedSubstanceSID]
      ,[PrincipalDiagnosisICD9SID]
      ,[PrincipalDiagnosisICD10SID]
      ,[PrincipalDiagnosisPOAIndicator]
      ,[AdmitMASMovementTypeSID]
      --,[AdmitFacilityMovementTypeSID]
      --,[AdmitFromInstitutionSID]
      --,[AdmitWardLocationSID]
      --,[AdmitRoomBedSID]
      ,[AdmitDiagnosis]
      --,[AdmitForServiceConnectedFlag]
      --,[AdmitRegulationSID]
      --,[AdmitASIHSequence]
      --,[ScheduledAdmissionFlag]
      --,[AdmitEnteredByStaffSID]
      --,[AdmitEnteredOnDateTime]
      --,[AdmitLastEditedByStaffSID]
      --,[AdmitLastEditedOnDateTime]
      --,[DischargeMASMovementTypeSID]
      --,[DischargeFacilityMovementTypeSID]
      --,[DischargeToInstitutionSID]
      --,[DischargeAttendingPhysicianSID]
      --,[DischargeASIHSequence]
      --,[DischargeEnteredByStaffSID]
      --,[DischargeEnteredOnDateTime]
      --,[DischargeLastEditedByStaffSID]
      --,[DischargeLastEditedOnDateTime]
      --,[SpecialtyCDR]
      --,[TransmitFlag]
      --,[DischargeFromSpecialtySID]
      --,[DischargeFromService]
      --,[DischargeDRGSID]
      ,[LOSInService]
      ,[LOSCumulative]
      --,[ProviderSID]
      --,[DischargeSuicideSelfInflict]
      --,[DischargePsychSeverity]
      --,[DischargePsychFunctional]
      --,[DischargePsychHighLevel]
      --,[LeaveDays]
      --,[DischargeAbusedSubstanceSID]
      --,[PassDays]
      ,[AgentOrangeFlag]
      ,[CombatFlag]
      ,[HeadNeckCancerFlag]
      ,[IonizingRadiationFlag]
      ,[LegionnairesDiseaseFlag]
      ,[MilitarySexualTraumaFlag]
      ,[ServiceConnectedFlag]
      ,[SHADFlag]
      ,[SWAsiaConditionsFlag]
      --,[FirstClosedOutDateTime]
      --,[FirstClosedOutVistaErrorDate]
      --,[FirstClosedOutDateTimeTransformSID]
      --,[DischargeWardLocationSID]
      --,[DischargeWardCDR]
      --,[DischargeSpecialtySID]
      --,[Discharge45WardLocationSID]
      --,[Discharge45SpecialtySID]
  FROM [CDWWork].[Inpat].[Inpatient]
  where PrincipalDiagnosisICD10SID = 1001480161

--outpatient
select top 10 
ICD10SID, EventDateTime, VisitDateTime, VDiagnosisDateTime
from Outpat.VDiagnosis
where ICD10SID = 1001480161
--EventDateTime usually NULL
--VisitDateTime approx equal to VDiagnosisDateTime

/* back to inpatient stays
but this time look at the other 2 tables */

select top 10 * from Inpat.InpatientDiagnosis
where ICD10SID = 1001480161
-- ordinal numbers are in the range of: 0 0 0 9 3 7 16 9 3 4

select top 10 * from Inpat.InpatientDischargeDiagnosis
where ICD10SID = 1001480161
-- similar pattern, ordinals are like: 1 1 1 1 4 8 8 14 5 11

-- CONCLUSION
-- we probably should use those two {InpatientDiagnosis and InpatientDischargeDiagnosis} and not "merely" inpat.inpatient
-- outpat may be best of all
-- ideally use all 3




/******** ******** ******** ******** ******** ******** ******** ******** ********/
/* lab */
select top 100 *
from CDWWork.dim.LabChemTest
where sta3n = 580 and (LabChemTestName like '%kappa%'
or LabChemTestName like '%lambda%')

select top 10 * from INFORMATION_SCHEMA.COLUMNS
where COLUMN_NAME like '%loinc%'

/* look for IgM */
SELECT  * from dim.LabChemTest
where Sta3n = 580 and LabChemTestName like '%igm%'
-- N = 123 matches
-- lots of anti-whatever IgM serologies. Infections, autoimmune.

-- hand made list
SELECT
LabChemTestSID, LabChemTestName
from dim.LabChemTest
where LabChemTestSID in (
	1000103387,
	1000031838,
	1000036993,
	1000051256,
	1000066082,
	1000057555,
	1000052052,
	1000036277
)
/*
RESULTS:

LabChemTestSID	LabChemTestName
1000031838	IGM ABS
1000036277	ZZIGM, CONVALESCENT
1000036993	IgM-Little Rock/d'cd 9/28/17
1000051256	IGM/BEFORE 08/24/02
1000052052	ZZIGM, ACUTE
1000057555	ZZIGM
1000066082	RESEARCH IGM
1000103387	IGM

*/

select * from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME like 'loinc%'
order by TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME

--look at contents of fact table
select top 10
[LabChemTestSID],
--[PatientSID], 
[LabChemSpecimenDateTime], 
[LabChemResultValue], [LabChemResultNumericValue], [TopographySID], 
[LOINCSID], [Units], [Abnormal], [RefHigh], [RefLow]
from chem.LabChem
where LabChemTestSID in (
	1000103387,
	1000031838,
	1000036993,
	1000051256,
	1000066082,
	1000057555,
	1000052052,
	1000036277
)
-- and LabChemSpecimenDateTime > '2015-01-01'  -- seems to perform badly w/ this.
-- numeric values like 1.3 to 97 (in the TOP 10). No crazy high ones.

--What labchemtestSIDs from my list actually get drawn in practice,
-- and what loincsid is associated with them?
select distinct * from (
	select top 100
	LabChemTestSID, LOINCSID
	from chem.LabChem
	where LabChemTestSID in (
		1000103387,
		1000031838,
		1000036993,
		1000051256,
		1000066082,
		1000057555,
		1000052052,
		1000036277
	)
) as x

/*
finding only these 3, but mind you, it's only top 100:
1000036993	IgM-Little Rock/d'cd 9/28/17
1000031838	IGM ABS
1000051256	IGM/BEFORE 08/24/02


LabChemTestSID	LOINCSID
1000036993	-1
1000031838	1000224138
1000051256	1000273133

Possibly I am missing the 1000103387 code, which looks like the best of all
*/

-- investigate just that one sid that looks most recent.
select top 3
[LabChemTestSID],
--[PatientSID], 
[LabChemSpecimenDateTime], 
[LabChemResultValue], [LabChemResultNumericValue], [TopographySID], 
[LOINCSID], [Units], [Abnormal], [RefHigh], [RefLow]
from chem.LabChem
where LabChemTestSID in (
1000031838
)

select 
LOINCSID, loinc, Component, Property, Units
from dim.LOINC where LOINCSID in (1000224138, 1000273133)
/*oh-ho, that 1000224138 code is some weird platelet thing.

LOINCSID	loinc	Component	Property	Units
1000224138	11125-2	PLATELET MORPHOLOGY FINDING	Presence or Identity	NULL
1000273133	2472-9	IGM	Mass Concentration	G/L;MG/DL

CONCLUSION!

The loincsid 1000273133 is what we want.
Therefore the "1000051256	IGM/BEFORE 08/24/02" is valid.
Problem is: it looks old.
*/

-- go looking for 103387: the best-looking labchemtestsid for IgM
-- I hope it is associated with a reassuring looking LOINC
select top 3
[LabChemTestSID],
[LabChemSpecimenDateTime], 
[LabChemResultValue], [LabChemResultNumericValue], [TopographySID], 
[LOINCSID], [Units], [Abnormal], [RefHigh], [RefLow]
from chem.LabChem
where LabChemTestSID in (
1000103387
)
--okay this performance is horrible; probably just too many rows in that fact table
-- Unfortunate. Can't look at values.

select * from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'LabChemTestSID'
order by TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME

select * from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'loincSID'
order by TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME

--here is an interesting dim that I found
--seems to have generic info about each labchemtestSID without results
--wild that things like LOINCSID get propagated into Chem.LabChem and not normalized out, but okay
select 
	LabChemTestSpecimenSID, LabChemTestSID, Sta3n, LOINCSID, LowReference, HighReference, Units
from dim.LabChemTestSpecimen
where LabChemTestSID = 1000103387

/*
Hooray, there is our hoped-for LOINCSID:

LabChemTestSpecimenSID	LabChemTestSID	Sta3n	LOINCSID	LowReference	HighReference	Units
1000098536	1000103387	580	1000273133	43	279	mg/dL
*/




/******** ******** ******** ******** ******** ******** ******** ******** ********/
/* Next diagnosis code:
Lymphoplasmacytic lymphoma (LPL)
 avoid ICD 91.1* because that is leukemia, not lymphoma

Supposedly C83.0* is the one because
"""Applicable To
Lymphoplasmacytic lymphoma
Nodal marginal zone lymphoma
Non-leukemic variant of B-CLL
Splenic marginal zone lymphoma"""

So it's C83.00 thru .09
*/

select *
from dim.ICD10
where ICD10Code like 'C83.0%'
	and Sta3n = 580
/*
results:

1001479964
1001479965
1001479966
1001479967
1001479968
1001479969
1001479970
1001479971
1001479972
1001479973
*/

select top 10 
ICD10SID, VisitDateTime
from Outpat.VDiagnosis
where ICD10SID in (
	1001479964,
	1001479965,
	1001479966,
	1001479967,
	1001479968,
	1001479969,
	1001479970,
	1001479971,
	1001479972,
	1001479973
)
--Conclusion:
--confirmed, found real signal. Those SIDs are in use.
--However, not clear to me (a general internist) whether this ICD (which means "Small cell B-cell lymphoma") will really be limited *only* to LPL,
--or whether other entities are mixed in there, and ICD-10 is not enough.

--NOTE TO SELF
--we haven't looked at problem list yet, either




/******************************************************************/
--A bit about viscosity; just a thought
select *
from dim.LabChemTest
where sta3n = 580
and LabChemTestName like '%viscosity%'
-- serum viscosity 1000044241

select * from dim.LabChemTestSpecimen where LabChemTestSID = 1000044241
-- loincsid 1000291041

select * from dim.LOINC where loincsid = 1000291041
-- just the one, for sta3n=580

select * from dim.LOINC where LOINC = '3128-6'
-- N = 130, approximately as expected.
