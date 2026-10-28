
// Bilateral migration datasource: https://data.mendeley.com/datasets/cpt3nh6jct/1
// This do file prepares a dta file for regression analysis which is used in 06_analysis.do

***Based on the path you clone this repository, set repository root***
global root "D:/project2025/mig_net/Population_Migration_Network"

import delimited "$root/data/cleaned/panel_migration.csv"
*It takes 2 minutes to load


//Preparing the data
gen stock_million = stock/1000000
gen flow_million = flow /1000000
gen lnflow = ln(flow + 1)
gen lnstock = ln(stock + 1)
label variable lnflow "ln(flow + 1)"
label variable lnstock "ln(stock + 1)"
label variable flow_million "flow /1000000"
label variable stock_million "stock/1000000"

encode dyad_id, gen(dyad)
label variable dyad "country pair in long format"
label variable dyad_id "country pair string format"
label variable gdp_pc "GDP per capita of Origin"
label variable gdp_pc_d "GDP per capita of destination"
label variable hdi "HDI value of origin [0,1]"
label variable hdi_d "HDI value of destination [0,1]"
label variable literacy_rate "Origin: Literacy rate, adult total (% of people ages>= 15) "
label variable literacy_rate_d "Destination: Literacy rate, adult total (% of people ages>= 15) "
label variable life_exp "Origin: Life expectancy at birth, total (years)"
label variable life_exp_d "Destination: Life expectancy at birth, total (years)"
label variable mortality "Origin: Mortality rate, infant (per 1,000 live births)"
label variable mortality_d "Destination: Mortality rate, infant (per 1,000 live births)"
label variable infant_survival "Origin: infant survival rate,(per 1,000 live births)"
label variable infant_survival_d "Destination: infant survival rate (per 1,000 live births)"
label variable secondary_enroll "Origin: School enrollment, secondary (% net) "
label variable secondary_enroll_d "Destination: School enrollment, secondary (% net) "
label variable tertiary_enroll "Origin: School enrollment, tertiary (% net) "
label variable tertiary_enroll_d "Destination: School enrollment, tertiary (% net) "
label variable primary_enroll "Origin: School enrollment, primary (% net) "
label variable primary_enroll_d "Destination: School enrollment, primary (% net) "
label variable mmr "Maternal Mortolity Ratio of Origin"
label variable mmr_d "Maternal Mortolity Ratio of Destination"
label variable maternal_survival "Maternal Survival Ratio of Origin"
label variable maternal_survival_d "Maternal Survival Ratio of Destination"
label variable lfp "Labor Force Particiaption of Origin"
label variable lfp_d "Labor Force Particiaption of Destination"
label variable hci "Human Capital Index of Origin"
label variable hci_d "Human Capital Index of Destination"
label variable employment "Maternal Mortolity Ratio of Origin"
label variable employment_d "Maternal Mortolity Ratio of Destination"
label variable maternal_death_risk "Risk of maternal death of Origin"
label variable maternal_death_risk_d "Risk of maternal death of Destination"
label variable nourishment "Prevalence of nourishment in Origin"
label variable nourishment_d "Prevalence of nourishment in Destination"
label variable undernourishment "Prevalence of undernourishment in Origin"
label variable undernourishment_d "Prevalence of undernourishment inDestination"
label variable gdp_pc "GDP per capita (constant 2015 US$) of Origin"
label variable gdp_pc_d "GDP per capita (constant 2015 US$) of destination"
label variable gii "Origin:Gender Inequality Index, 0:Complete equality, 1:Complete inequality"
label variable gii_d "Destination:Gender Inequality Index, 0:Complete equality, 1:Complete inequality"
label variable gini "Origin:Gini coefficient,0 (Perfect Equality),1 (Perfect Inequality)"
label variable gini_d "Destination:Gini coefficient,0 (Perfect Equality),1 (Perfect Inequality)"
label variable lfp_f "Origin: Labour force participation rate, female (% ages 15 and older)"
label variable lfp_f_d "Destination: Labour force participation rate, female (% ages 15 and older)"
label variable mean_schooling "Origin: Mean Years of Schooling (years)"
label variable mean_schooling_d "Destination: Mean Years of Schooling (years)"
label variable coef_human_inequality "O: unweighted mean of inequalities across health, education, income; 0:perfect equality,100:perfect inequality"
label variable coef_human_inequality_d "D: unweighted mean of inequalities across health, education, income; 0:perfect equality,100:perfect inequality"
label variable inequality_edu "O:0:same number of years of scooling by everyone,100:1 person have all education, rest have none"
label variable inequality_edu_d "D:0:same number of years of scooling by everyone,100:1 person have all education, rest have none"
label variable inequality_income "O:0:every HH has same income,100:one HH has all income, rest has zero"
label variable inequality_income_d "D:0:every HH has same income,100:one HH has all income, rest has zero"
label variable inequality_le "O:0:everybody lives to the same age,100:one person has all years of life, rest zero"
label variable inequality_le_d "D:0:everybody lives to the same age,100:one person has all years of life, rest zero"
label variable electoral_dem_index "O: V_dem EDI:0 = Not democratic, 1 = Most democratic"
label variable electoral_dem_index_d "D: V_dem EDI:0 = Not democratic, 1 = Most democratic"
label variable government_effec_index "O:WGI GEI (-2.5 to +2.5 (higher is better))"
label variable government_effec_index_d "D:WGI GEI (-2.5 to +2.5 (higher is better))"
label variable political_corruption_index "O:V-dem PCI: 0:no corruption, 1: Highest corruption"
label variable political_corruption_index_d "O:V-dem PCI: 0:no corruption, 1: Highest corruption"
label variable population_growth "Origin: Population growth (annual %)"
label variable population_growth_d "Destination: Population growth (annual %)"
label variable idealpoint "O:UNGA Ideal Point Distance,closer to 3:'Liberal', closer to -3:'Non-Revisionist', closer to 0:'Swing states'"
label variable idealpoint_d "D:UNGA Ideal Point Distance,near 3:'Liberal',near -3:'Non-Revisionist', near 0:'Swing states'"
label variable core_3 "Origin:1 = core, 2 = semi-periphery, 3 = periphery"
label variable core_3_d "Destination:1 = core, 2 = semi-periphery, 3 = periphery"
label variable sigma_in "Origin: Core–periphery fit based on incoming ties"
label variable sigma_all_d "Destination: Core–periphery fit based on incoming ties"
label variable sigma_out "Origin: Core–periphery fit based on outgoing ties"
label variable sigma_out_d "Destination: Core–periphery fit based on outgoing ties"
label variable sigma_in_d "Destination: Core–periphery fit based on incoming ties"
label variable sigma_all "Origin:Overall core–periphery fit (weighted, undirected)"
label variable sigma_all_d "Destination: Overall core–periphery fit (weighted, undirected)"
label variable all_cp_d "Destination: Overall core–periphery class (1 = core, 0 = periphery)"
label variable all_cp "Origin: Overall core–periphery class (1 = core, 0 = periphery)"
label variable in_cp "Origin: Incoming core–periphery class (1 = core, 0 = periphery)"
label variable in_cp_d "Destination: Incoming core–periphery class (1 = core, 0 = periphery)"
label variable out_cp "Origin: Outgoing core–periphery class (1 = core, 0 = periphery)"
label variable out_cp_d "Destination: Outgoing core–periphery class (1 = core, 0 = periphery)"
label variable rank "Origin: Overall core–periphery rank"
label variable rank_d "Destination: Overall core–periphery rank"
label variable rankin "Origin: Incoming core–periphery rank"
label variable rankin_d "Destination: Incoming core–periphery rank"
label variable rankout_d "Destination: Outgoing core–periphery rank"
label variable rankout "Origin: Outgoing core–periphery rank"
label variable out_deg_d "Origin: weighted outdegree of destination countries"
label variable in_deg_d "Origin: weighted indegree of destination countries"
label variable out_deg_d "Destination: weighted outdegree of destination countries"
label variable in_deg_d "Destination: weighted indegree of destination countries"
label variable out_deg "Origin: weighted out degree centrality of origin countries"
label variable in_deg "Origin: weighted in degree centrality of origin countries"
label variable log_in_deg "Origin: log transformed in degree"
label variable log_out_deg "Origin: nlog transformed out degree"
label variable log_in_deg_d "Destination: log transformed indegree of destination"
label variable log_out_deg_d "Destination: log transformed outdegree of destination"
label variable alpha "0:pure no. of connection, 1:pure total migration, 0.8:flow dominant, 0.5:balance"

encode type_hybrid, gen(type_hybrid_num)
codebook type_hybrid_num
label variable type_hybrid "Origin:1:hub, 2:peryphery, 3:pure magnet, 4:pure source"
encode type_hybrid_d, gen(type_hybrid_d_num)
codebook type_hybrid_d_num
label variable type_hybrid_d_num "Destination:1:hub, 2:peryphery, 3:pure magnet, 4:pure source"
encode core_4, gen(core_4_num)
codebook core_4_num
label variable core_4_num `"Origin 1 "periphery", 2 "pure_magnet ", 3 "pure_source ", 4 "transition"'

encode core_4_d, gen(core_4_d_num)
codebook core_4_d_num
label variable core_4_d_num `"Destination 1 "periphery", 2 "pure_magnet ", 3 "pure_source ", 4 "transition"'

label variable stock "Stock of migrants born in the origin, living in destination"
label variable flow "Net flows of migrants born in the origin, moving to the destination"
label variable origin "Source country"
label variable destination "Country receiveing people from the source country"
label variable year "from 1990 to 2020"
label variable iso_o "Alpha 3 code for the origin countries"
label variable region "Region of the origin"
label variable region_d "Region of the destination"
label variable parliament_seat_f "O:Share of seats in parliament, female (% held by women)"
label variable parliament_seat_f_d "D:Share of seats in parliament, female (% held by women)"
label variable session_x "Parliament session"


// Preparing the distance variables

// Economic distance measures
gen lgdppc_o = ln(gdp_pc)
gen lgdppc_d = ln(gdp_pc_d)
label variable lgdppc_o "log transformed GDP per capita of origin"
label variable lgdppc_d "log transformed GDP per capita of destination"
gen singed_lngdpdiff = sign(gdp_pc - gdp_pc_d) * ln(abs(gdp_pc - gdp_pc_d))
label variable singed_lngdpdiff "O-D diff. in logGDP pc"

gen gini_distance = gini - gini_d
label variable gini_distance "O-D diff. in GINI coefficients"

gen ineq_inc_dist = inequality_income - inequality_income_d
label variable ineq_inc_dist "O-D diff. in income inequalities"

gen lfp_distance = lfp - lfp_d
label variable lfp_distance "O-D diff. in LFP"

gen hci_distance = hci - hci_d
label variable hci_distance "O-D diff. in HCI+"

gen emp_distance = employment - employment_d
label variable emp_distance "O-D diff. in employment"


// Gender/Cultural 
gen GII_distance = gii - gii_d
label variable GII_distance "O-D diff. in gender inequality index values"

gen FLFP_distance = lfp_f - lfp_f_d
label variable FLFP_distance "O-D diff. in the share of female parliament members"

gen c_human_ineq_dist = coef_human_inequality - coef_human_inequality_d
label variable c_human_ineq_dist "O-D diff. in the coefficients of human inequality by UNDP"

gen hdi_distance = hdi - hdi_d
label variable hdi_distance "O-D diff. in HDI"

gen f_parliament_dist = parliament_seat_f - parliament_seat_f_d
label variable f_parliament_dist "O-D diff. in share of female members in the parliament"

// Health
gen infnt_mrtlty_dist = mortality - mortality_d
label variable infnt_mrtlty_dist "O-D diff. in the mortality values of the countries"

gen life_exp_distance = life_exp - life_exp_d
label variable life_exp_distance "O-D diff. in life expectancy"

gen ineq_LE_dist = inequality_le - inequality_le_d
label variable ineq_LE_dist "O-D diff. in inequality of life expectancy by UNDP"

gen mmr_distance = mmr - mmr_d
label variable mmr_distance "O-D diff. in maternal mortality"

gen mdr_distance = maternal_death_risk - maternal_death_risk_d
label variable mdr_distance "O-D diff. in risk of maternal death"

gen infant_survival_distance = infant_survival- infant_survival_d
label variable infant_survival_distance "O-D diff. in infant mortality"

gen maternal_survival_dist = maternal_survival- maternal_survival_d
label variable maternal_survival_dist "O-D diff. in maternal survival rate of O and D"

gen nourishment_distance = nourishment- nourishment_d
label variable nourishment_distance "O-D diff. in nourishment rate"

gen undernourishment_distance = undernourishment- undernourishment_d
label variable undernourishment_distance "O-D diff. in undernourishment rate of O and D"


// Education
gen primary_en_dist = primary_enroll - primary_enroll_d
label variable primary_en_dist "O-D diff. in primary enrollment"

gen secondary_en_dist = secondary_enroll - secondary_enroll_d
label variable secondary_en_dist "O-D diff. in sec. level enrolment"

gen tertiary_en_dist = tertiary_enroll - tertiary_enroll_d
label variable tertiary_en_dist "O-D diff. in ter. level enrolment"

gen lit_rate_dist = literacy_rate - literacy_rate_d
label variable lit_rate_dist "O-D diff. in literacy rate"

gen yrs_schl_dist = mean_schooling - mean_schooling_d
label variable yrs_schl_dist "O-D diff. in mean years of schooling"

gen ineq_ed_dist = inequality_edu - inequality_edu_d
label variable ineq_ed_dist "O-D diff. in inequality of education by UNDP"



// Institution
gen GEI_distance = government_effec_index - government_effec_index_d
label variable GEI_distance "O-D diff. in Government Effectiveness Index between countries"

gen PCI_distance = political_corruption_index - political_corruption_index_d
label variable PCI_distance "O-D diff. in Political Corruption Index between countries"


// Controls
gen idealpoint_dist = idealpoint - idealpoint_d
label variable idealpoint_dist "bilateral political tension: 'Low Distance':'friendship, 'High Distance':'tension' "

gen pop_gr_dist = population_growth - population_growth_d
label variable pop_gr_dist "O-D diff. in the annual population growth rate of origin and destination countries"

gen edi_distance = electoral_dem_index - electoral_dem_index_d
label variable edi_distance "O-D diff. in EDI value of origin and destination countries"

gen immun_dpt_dist = dpt_immunization - dpt_immunization_d
label variable immun_dpt_dist "O-D diff. in DPT immunization rate of origin and destination countries"


xtset dyad year

// Making interaction terms and IV for interaction terms
gen lnstock_lag1 = L.lnstock
label variable lnstock_lag1 "Lag one of the lnstock variable"

//42 new variables for 21 distance variables
foreach var in singed_lngdpdiff gini_distance ineq_inc_dist GII_distance FLFP_distance f_parliament_dist c_human_ineq_dist hdi_distance infnt_mrtlty_dist life_exp_distance ineq_LE_dist primary_en_dist tertiary_en_dist secondary_en_dist mmr_distance mdr_distance lit_rate_dist yrs_schl_dist ineq_ed_dist GEI_distance PCI_distance idealpoint_dist pop_gr_dist edi_distance immun_dpt_dist infant_survival_distance maternal_survival_dist nourishment_distance undernourishment_distance emp_distance hci_distance lfp_distance {

    gen int_`var'      = lnstock * L.`var'
    gen int_`var'_iv = lnstock_lag1 * L.`var'
}



label variable int_singed_lngdpdiff "interaction of L.Log GDP per capita and migration stock"
label variable int_singed_lngdpdiff_iv "IV for L.Log GDP per capita interaction"
label variable int_gini_distance "interaction of L.GINI_distance and migration stock"
label variable int_gini_distance_iv "IV for L.GINI distance and migration stock interaction"
label variable int_mmr_distance "interaction of L.mmr_distance and migration stock"
label variable int_mmr_distance_iv "IV for L.mmr distance and migration stock interaction"
label variable int_mdr_distance "interaction of L.mdr_distance and migration stock"
label variable int_mdr_distance_iv "IV for L.mdr distance and migration stock interaction"
label variable int_tertiary_en_dist "interaction of L.tertiary_en_dist and migration stock"
label variable int_tertiary_en_dist_iv "IV for L.tertiary enrollment distance and migration stock interaction"
label variable int_secondary_en_dist "interaction of L.secondary_en_dist and migration stock"
label variable int_secondary_en_dist_iv "IV for L.secondary enrollment distance and migration stock interaction"
label variable int_primary_en_dist "interaction of L.primary_enrollment_distance and migration stock"
label variable int_primary_en_dist_iv "IV for L.primary enrollment distance and migration stock interaction"

label variable int_ineq_inc_dist "interaction of L.income inequality distance and migration stock"
label variable int_ineq_inc_dist_iv "IV for L.income inequality  distance and migration stock interaction"
label variable int_GII_distance "interaction of L.GII_distance and migration stock"
label variable int_GII_distance_iv "IV for L.GII_distance and migration stock interaction"
label variable int_FLFP_distance "interaction of L.FLFP_distance and migration stock"
label variable int_FLFP_distance_iv "IV for FLFP distance and migration stock interaction"
label variable int_hdi_distance "interaction of L.HDI_distance and migration stock"
label variable int_hdi_distance_iv "IV for HDI distance and migration stock interaction"
label variable int_GEI_distance "interaction of L.GEI_distance and migration stock"
label variable int_GEI_distance_iv "IV for GEI distance and migration stock interaction"
label variable int_PCI_distance "interaction of L.PCI_distance and migration stock"
label variable int_PCI_distance_iv "IV for PCI distance and migration stock interaction"
label variable int_idealpoint_dist "interaction of L.idealpoint_distance and migration stock"
label variable int_idealpoint_dist_iv "IV for L.idealpoint distance and migration stock interaction"
label variable int_edi_distance "interaction of L.EDI_distance and migration stock"
label variable int_edi_distance_iv "IV for L.EDI distance and migration stock interaction"
label variable int_f_parliament_dist "interaction of L.Female_parliament_distance and migration stock"
label variable int_f_parliament_dist_iv "IV for L.female parliament members share distance and migration stock interaction"
label variable int_c_human_ineq_dist "interaction of L.coeff_human_ineq_distance and migration stock"
label variable int_c_human_ineq_dist_iv "IV for L.coef. of human inequality distance and migration stock interaction"
label variable int_infnt_mrtlty_dist "interaction of L.moratility_rate_distance and migration stock"
label variable int_infnt_mrtlty_dist_iv "IV for L.mortality distance and migration stock interaction"
label variable int_life_exp_distance "interaction of L.LE_distance and migration stock"
label variable int_life_exp_distance_iv "IV for L.life expectancy distance and migration stock interaction"
label variable int_ineq_LE_dist "interaction of L.inequality_LE_distance and migration stock"
label variable int_ineq_LE_dist_iv "IV for L.inequality in LE distance and migration stock interaction"
label variable int_lit_rate_dist "interaction of L.literacy rate distance and migration stock"
label variable int_lit_rate_dist_iv "IV for L.literacy rate distance and migration stock interaction"
label variable int_yrs_schl_dist "interaction of L.mean_years_schooling_distance and migration stock"
label variable int_yrs_schl_dist_iv "IV for L.mean year of schooling distance and migration stock interaction"
label variable int_ineq_ed_dist "interaction of L.inequality_in_education_distance and migration stock"
label variable int_ineq_ed_dist_iv "IV for L.inequality in education distance and migration stock interaction"
label variable int_pop_gr_dist "interaction of L.population_growth_rate_distance and migration stock"
label variable int_pop_gr_dist_iv "IV for L.Population growth rate distance and migration stock interaction"
label variable int_immun_dpt_dist "interaction of L.DPT_immunization_rate_distance and migration stock"
label variable int_immun_dpt_dist_iv "IV for L.DPT immunization rate distance and migration stock interaction"
label variable int_infant_survival_distance "interaction of L.infant_survival_distance and migration stock"
label variable int_infant_survival_distance_iv "IV for L.infant_survival distance and migration stock interaction"
label variable int_maternal_survival_dist "interaction of L.maternal_survival_distance and migration stock"
label variable int_maternal_survival_dist_iv "IV for L.maternal_survival distance and migration stock interaction"
label variable int_nourishment_distance "interaction of L.nourishment_distance and migration stock"
label variable int_nourishment_distance_iv "IV for L.norishment distance and migration stock interaction"
label variable int_undernourishment_distance "interaction of L.undernourishment_distance and migration stock"
label variable int_undernourishment_distance_iv "IV for L.undernorishment distance and migration stock interaction"
label variable int_emp_distance "interaction of L.emp_distance and migration stock"
label variable int_emp_distance_iv "IV for L.employment distance and migration stock interaction"
label variable int_hci_distance "interaction of L.hci_distance and migration stock"
label variable int_hci_distance_iv "IV for L.hci distance and migration stock interaction"
label variable int_lfp_distance "interaction of L.lfp_distance and migration stock"
label variable int_lfp_distance_iv "IV for L.lfp distance and migration stock interaction"


tab corridor
codebook corridor
label variable corridor "1= PP, 2 = CP, 3 = PC, 4 = CC"
//graph bar (mean) lnstock if year == 1990, over(corridor)
//graph bar (mean) lnstock if year == 2010, over(corridor)


********sanity check
distinct origin
distinct destination
distinct year
distinct origin if year == 1990
distinct origin if year == 2009
distinct origin if year == 2010
distinct origin if year == 2019


//saving a .dta file for regression analysis 
***** Based on the path you cloned this repository, change the following code" 
save "$root/data/cleaned/panel_complete.dta", replace


preserve
collapse (mean) stock_million, by(year corridor)
reshape wide stock_million, i(year) j(corridor)
egen total_stock = rowtotal(stock_million1 stock_million2 stock_million3 stock_million4)
foreach v of numlist 1/4 {
    gen pct`v' = 100*stock_million`v'/total_stock if total_stock != 0
}

graph bar (asis) pct1 pct2 pct3 pct4, over(year, label(labsize(vsmall) angle(45))) stack bar(1, color("brown")) bar(2, color("sand")) bar(3, color("eltblue")) bar(4, color("bluishgray")) blabel(bar, position(center) format(%4.1f) size(vsmall) color(black)) ytitle("Share of total (%)", size(vsmall)) ylabel(0(20)100, labsize(vsmall)) legend(order(1 "Periphery-periphery" 2 "Core-periphery" 3 "Periphery-core" 4 "Core-core") position(6) rows(1) size(vsmall))




collapse (mean) lnstock, by(year corridor)
reshape wide lnstock, i(year) j(corridor)

graph bar stock_million, over(year, label(angle(45) labsize(vsmall))) ///
    over(corridor) ///
    ytitle("Average migrant stock (millions)") ///
    title("Average Migrant Stock by Corridor Type Over Time") ///
    legend(off)
// graph bar lnstock1 lnstock2 lnstock3 lnstock4, over(year, label(labsize(vsmall) angle(45))) stack bar(1, color("brown")) bar(2, color("sand")) bar(3, color("eltblue")) bar(4, color("bluishgray")) ytitle("Mean lnstock", size(small)) ylabel(0(10)30, labsize(vsmall)) legend(order(1 "Periphery-periphery" 2 "Core-periphery" 3 "Periphery-core" 4 "Core-core") position(6) rows(1) size(small))

egen total_lnstock = rowtotal(lnstock1 lnstock2 lnstock3 lnstock4)
foreach v of numlist 1/4 {
    gen pct`v' = 100*lnstock`v'/total_lnstock if total_lnstock != 0
}

// Stacked baar chart with no percentage mentioned 
//graph bar (asis) pct1 pct2 pct3 pct4, over(year, label(labsize(vsmall) angle(45))) stack bar(1, color("brown")) bar(2, color("sand")) bar(3, color("eltblue")) bar(4, color("bluishgray")) ytitle("Share of total (%)", size(small)) ylabel(0(20)100, labsize(vsmall)) legend(order(1 "Periphery-periphery" 2 "Core-periphery" 3 "Periphery-core" 4 "Core-core") position(6) rows(1) size(small))
		   
// Stacked baar chart with percentage mentioned 		   
graph bar (asis) pct1 pct2 pct3 pct4, over(year, label(labsize(vsmall) angle(45))) stack bar(1, color("brown")) bar(2, color("sand")) bar(3, color("eltblue")) bar(4, color("bluishgray")) blabel(bar, position(center) format(%4.1f) size(vsmall) color(black)) ytitle("Share of total (%)", size(vsmall)) ylabel(0(20)100, labsize(vsmall)) legend(order(1 "Periphery-periphery" 2 "Core-periphery" 3 "Periphery-core" 4 "Core-core") position(6) rows(1) size(vsmall))
		   
		   		   
// Stacked baar chart with percentage mentioned (Horizontal)
//graph bar (asis) pct1 pct2 pct3 pct4, over(year, label(labsize(vsmall))) stack horizontal bar(1, color("brown")) bar(2, color("sand")) bar(3, color("eltblue")) bar(4, color("bluishgray")) blabel(bar, position(center) format(%4.1f) size(vsmall) color(black)) ylabel(, labsize(vsmall)) legend(order(1 "Periphery-periphery" 2 "Core-periphery" 3 "Periphery-core" 4 "Core-core") position(6) rows(1) size(small))
		   
*** The following code will run only when the Graph window is kept open.		   
graph export "$root/outputs/Fig2.tif", as(tif) name("Graph")
restore


