df <- foreign::read.spss(
  file = "data/raw/banco-conversao-16-10-20.sav",
  to.data.frame = TRUE
)

df <- df[!is.na(df$mora_t2), ]

df$BDI_total <- rowSums(df[, grepl("^BDI", names(df))])

cols_to_keep <- c(
  "rec", # ID
  "a03sexo_t2", # Gender
  "a03corpele_t2", # Skin color
  "a05idade_t2", # Age (in years)
  "a06estano_t2", # Studying in current year?
  "a06esteanoa_t2", # Years of education
  "a10trabdin_t2", # Worked for money (lifetime)
  "a12traba_t2", # Currently working?
  "a15acomod_t2", # Type of accommodation
  "a15filho_t2", # Has children?
  "a15qtfil_t2", # How many children?
  "a15religi_t2", # Do you have a religion?
  "a16tratpsic_t2", # Lifetime psychological treatment
  "a17tratpsic_t2", # For how long (in months)?
  "a18tratpsia_t2", # Lifetime psychiatric treatment
  "a18tratpsib_t2", # How many psychiatrists?
  "a19tratpsi_t2", # For how long (in months)?
  "a20medicpsi_t2", # Have you ever taken any psychiatric medication?
  "a20medicpsib_t2", # How many different psychiatric medications?
  "a20medicpsic_t2", # For how long (medication treatment)?
  "a21reghumr_t2", # Lifetime mood stabilizer
  "a22antipsic_t2", # Lifetime antipsychotics
  "a23antideprs_t2", # Lifetime antidepressants or antianxiety drugs?
  "a24bzdp_t2", # Lifetime benzodiazepine
  "a25barb_t2", # Lifetime barbiturates
  "a26natur_t2", # Lifetime herbal medicines
  "a27moutrs_t2", # Lifetime other non-listed medications
  "a28medica_t2", # What medications have you taken throughout your life?
  "a29medica_t2", # What psychiatric medications are you currently taking?
  "a30interp_t2", # Have you ever been admitted to a psychiatric hospital?
  "a31interv_t2", # How many times have you been admitted to ""?
  "a32caps_t2", # Have you ever used public mental health services?
  "a32interv01_t2", # Has a doctor ever diagnosed you with bipolar disorder?
  "a36relaciona_t2", # Are you married, dating or have a partner?
  "b00doefam_t2", # Anyone in your family with a psychiatric history
  "b01famil1_t2", # Did your mother have any psychiatric illness?
  "b02doenca1_t2", # What psychiatric illness did your mother have or had?
  "b03med1_t2", # Mother used or she is using psychiatric medication
  "b04interna1_t2", # Mother ever been admitted to a psychiatric hospital?
  "b06tentsu1_t2", # Has your mother ever attempted suicide?
  "b07qtentsu1_t2", # How many times?
  "b08famil2_t2", # Did your father have any psychiatric illness?
  "b09doenca2_t2", # What psychiatric illness did your father have or had?
  "b10med2_t2", # Has your father used or is he using psychiatric medication
  "b11interna2_t2", # Father ever been admitted to a psychiatric hospital
  "b13tentsu2_t2", # Has your father ever attempted suicide?
  "b14qtentsu2_t2", # How many times?
  "idadrog_t2", # At what age (in years) did you first try a substance?
  "mora_t2", # How many people live with you?
  "polaride_t2", # Was the first mood episode depression or hypo(mania)?
  "miniA08AT_t2", # Current major depressive episode
  "miniA08ATPA_t2", # Current atypical depressive episode
  "miniA15b_t2", # Current major depressive episode w. melancholic features
  "TB_erros", # Mood episode consensus
  "miniA11_t2", # Age of first depressive episode
  "miniA12_t2", # Number of depressive episodes
  "miniA13_t2", # BD family history
  "PSQI_COMP1", # PSQI component 1: Subjective sleep quality
  "PSQI_COMP2", # PSQI component 2: Sleep latency
  "PSQI_COMP3", # PSQI component 3: Sleep duration
  "PSQI_COMP4", # PSQI component 4: Habitual sleep efficiency
  "PSQI_COMP5", # PSQI component 5: Sleep disturbances
  "PSQI_COMP6", # PSQI component 6: Use of sleeping medication
  "PSQI_COMP7", # PSQI component 7: Daytime dysfunction
  "PSQI_total", # PSQI total score (sum of previous components)
  "FAST_auton_t2", # FAST domain 1: Autonomy
  "FAST_trab_t2", # FAST domain 2: Occupational functioning
  "FAST_cogn_t2", # FAST domain 3: Cognitive functioning
  "FAST_finan_t2", # FAST domain 4: Financial issues
  "FAST_relac_t2", # FAST domain 5: Interpersonal relationships
  "FAST_lazer_t2", # FAST domain 6: Leisure time
  "FAST_total_t2", # FAST total score
  "BRIAN_sono_t2", # BRIAN domain 1:
  "BRIAN_ativ_t2", # BRIAN domain 2:
  "BRIAN_social_t2", # BRIAN domain 3:
  "BRIAN_alim_t2", # BRIAN domain 4:
  "BRIAN_total_t2", # BRIAN total score
  "BDI_total" # BDI total score
)

df <- df[, cols_to_keep]

saveRDS(object = df, file = "data/processed/cleaned.rds")
