

clear

***Based on the path you clone this repository, set repository root.***
global root "D:/project2025/mig_net/Population_Migration_Network"


use "$root/data/cleaned/panel_complete.dta", clear

drop alpha flow_million type_hybrid_num type_hybrid_d_num core_4_num core_4_d_num lgdppc_o lgdppc_d
drop stock session_x 
drop median_sigma_out log_in_deg-median_sigma_out_d log_in_deg_d lnflow

tab corridor
*** Getting familiar with the data 
//codebook origin destination year dyad
// 203*202*31=1271186, which matches the number of observations.
// 203*202=41006 pairs = dyad

/*
tab year 
foreach t in 1990 2009 2010 2019{
	tab year if year==`t'
	codebook origin destination if year==`t'
}
*/


foreach var in hdi_distance{
	replace `var'=`var'*100
}


global outcomes singed_lngdpdiff lfp_distance emp_distance mmr_distance infnt_mrtlty_dist life_exp_distance secondary_en_dist tertiary_en_dist yrs_schl_dist hdi_distance 
sum $outcomes
global control1 primary_en_dist immun_dpt_dist


foreach var in $outcomes{
	local label: variable label `var'
	la var int_`var' "L. `label' X Migration"
	la var int_`var'_iv "IV for L. `label' X Migration"
}

*** Beta convergence
est clear
foreach var in $outcomes{
    eststo: reghdfe `var' L.`var' $control1, absorb(dyad year) vce(robust) // vce (cluster dyad)
	estadd ysumm
}

esttab using "$root/outputs/Beta_Converge.tex", drop($control1 _cons) scalar (ymean) replace f $regtab_format



*** Does migration help achieve convergence

* OLS results
est clear
foreach var in $outcomes{
     eststo: reghdfe `var' L.`var' lnstock int_`var' $control1, absorb(dyad year) vce(robust)  // cluster(dyad)
	estadd ysumm
}
esttab using "$root/outputs/Mig_Converge_OLS.tex", drop(L.* $control1) scalar (ymean) replace f $regtab_format

* First-stage results
est clear
foreach var in $outcomes{
     eststo: reghdfe lnstock L.`var' lnstock_lag1 int_`var'_iv $control1, absorb(dyad year) vce(robust)  // cluster(dyad)
}
esttab using "$root/outputs/Mig_Converge_FS1.tex", drop(L.* $control1) replace f $regtab_format

est clear
foreach var in $outcomes{
     eststo: reghdfe int_`var' L.`var' lnstock_lag1 int_`var'_iv $control1, absorb(dyad year) vce(robust)  // cluster(dyad)
}
esttab using "$root/outputs/Mig_Converge_FS2.tex", drop(L.* $control1) replace f $regtab_format

* 2SLS results
est clear
foreach var in $outcomes{
    eststo: ivreghdfe `var' L.`var' (lnstock int_`var' = lnstock_lag1 int_`var'_iv) $control1, absorb(dyad year) first robust  // cluster(dyad)
	estadd ysumm
}

esttab using "$root/outputs/Mig_Converge_2SLS.tex", drop(L.* $control1) scalar (ymean idstat idp widstat) replace f $regtab_format


*** 
pwcorr lnstock in_cp, sig
pwcorr lnstock corridor, sig

**** Heterogeneity Analysis

// log using "$root/outputs/Heterogeneity_2SLS.smcl", replace 
// est clear
// *******************The following code runs 
// *foreach var in lfp_distance{
// foreach var in $outcomes{
// eststo: ivreghdfe `var' L.`var' $control1 ib1.corridor c.L.`var'#ib1.corridor ///
//     (c.lnstock c.int_`var' c.lnstock#ib1.corridor c.int_`var'#ib1.corridor ///
//     = c.lnstock_lag1 c.int_`var'_iv c.lnstock_lag1#ib1.corridor c.int_`var'_iv#ib1.corridor), ///
//     absorb(dyad year) robust  // cluster(dyad)
// }
//
// log close 
//

preserve
tempname handle
local results "2SLS_heterogeneity.dta"

postfile `handle' ///
    str40 outcome str100 variable ///
    double estimate se t_stat p_value ci_lower ci_upper ///
    using "`results'", replace

foreach var in $outcomes {

    quietly ivreghdfe `var' L.`var' $control1 ib1.corridor ///
        c.L.`var'#ib1.corridor ///
        (c.lnstock c.int_`var' ///
        c.lnstock#ib1.corridor c.int_`var'#ib1.corridor ///
        = c.lnstock_lag1 c.int_`var'_iv ///
        c.lnstock_lag1#ib1.corridor ///
        c.int_`var'_iv#ib1.corridor), ///
        absorb(dyad year) robust

    local df = e(df_r)
    if missing(`df') | `df' <= 0 {
        local df = .
    }

    matrix b = e(b)
    matrix V = e(V)
    local names : colnames b

    foreach x of local names {
        local beta = b[1,"`x'"]
        local stderr = sqrt(V["`x'","`x'"])

        if `stderr' > 0 & `stderr' < . {
            local t = `beta'/`stderr'

            if `df' < . {
                local p = 2*ttail(`df',abs(`t'))
                local crit = invttail(`df',0.025)
            }
            else {
                local p = 2*normal(-abs(`t'))
                local crit = invnormal(0.975)
            }

            local lo = `beta' - `crit'*`stderr'
            local hi = `beta' + `crit'*`stderr'
        }
        else {
            local t = .
            local p = .
            local lo = .
            local hi = .
        }

        post `handle' ("`var'") ("`x'") ///
            (`beta') (`stderr') (`t') (`p') (`lo') (`hi')
    }
}

postclose `handle'

use "2SLS_heterogeneity.dta", clear

export delimited using "$root/data/cleaned/2SLS_heterogeneity.csv", replace
restore


**************************LIML regression
ssc install ivreg2, replace
ssc install reghdfe, replace
ssc install ivreghdfe, replace

* Does migration helps?
est clear
foreach var in $outcomes {
    eststo: ivreghdfe `var' L.`var' $control1 ///
        (lnstock int_`var' = lnstock_lag1 int_`var'_iv), ///
        absorb(dyad year) liml robust first

    estadd ysumm
}

esttab using "$root/outputs/Mig_Converge_LIML.tex", drop(L.* $control1) scalar (ymean idstat idp widstat) replace f $regtab_format


* Heterogeneity analysis with LIML


log using "$root/outputs/Heterogeneity_LIML.smcl", replace 
est clear
*******************The following code runs 
*foreach var in lfp_distance{

foreach var in $outcomes {
    eststo: ivreghdfe `var' L.`var' $control1 ib1.corridor ///
        c.L.`var'#ib1.corridor ///
        (c.lnstock c.int_`var' ///
        c.lnstock#ib1.corridor c.int_`var'#ib1.corridor ///
        = c.lnstock_lag1 c.int_`var'_iv ///
        c.lnstock_lag1#ib1.corridor c.int_`var'_iv#ib1.corridor), ///
        absorb(dyad year) liml robust
}


log close 


preserve
tempname handle
local results "LIML_heterogeneity.dta"

postfile `handle' ///
    str40 outcome str100 variable ///
    double estimate se t_stat p_value ci_lower ci_upper ///
    using "`results'", replace

foreach var in $outcomes {

    quietly ivreghdfe `var' L.`var' $control1 ib1.corridor ///
        c.L.`var'#ib1.corridor ///
        (c.lnstock c.int_`var' ///
        c.lnstock#ib1.corridor c.int_`var'#ib1.corridor ///
        = c.lnstock_lag1 c.int_`var'_iv ///
        c.lnstock_lag1#ib1.corridor ///
        c.int_`var'_iv#ib1.corridor), ///
        absorb(dyad year) liml robust

    local df = e(df_r)
    if missing(`df') | `df' <= 0 {
        local df = .
    }

    matrix b = e(b)
    matrix V = e(V)
    local names : colnames b

    foreach x of local names {
        local beta = b[1,"`x'"]
        local stderr = sqrt(V["`x'","`x'"])

        if `stderr' > 0 & `stderr' < . {
            local t = `beta'/`stderr'

            if `df' < . {
                local p = 2*ttail(`df',abs(`t'))
                local crit = invttail(`df',0.025)
            }
            else {
                local p = 2*normal(-abs(`t'))
                local crit = invnormal(0.975)
            }

            local lo = `beta' - `crit'*`stderr'
            local hi = `beta' + `crit'*`stderr'
        }
        else {
            local t = .
            local p = .
            local lo = .
            local hi = .
        }

        post `handle' ("`var'") ("`x'") ///
            (`beta') (`stderr') (`t') (`p') (`lo') (`hi')
    }
}

postclose `handle'

use "LIML_heterogeneity.dta", clear

export delimited using "$root/data/cleaned/LIML_heterogeneity.csv", replace
restore










