source("./scripts/00_utils.R")

raw <- foreign::read.spss(
  file = "./data/raw/banco-conversao-16-10-20.sav",
  to.data.frame = TRUE
)

# NOTE: Get subset of 468 subjects that were reassessed 3 years later
df <- raw[!is.na(raw$mora_t2), ]

df$BDI216_t2 <- sapply(df$BDI216_t2, recode_bdi_item)
df$BDI218_t2 <- sapply(df$BDI218_t2, recode_bdi_item)
df$BDI_total <- rowSums(df[, grepl("^BDI2", names(df))])

df$diagnosis <- make_diagnosis(
  bd = df$TB_erros,
  cur_dep = df$miniA08AT_t2,
  cur_atp_dep = df$miniA08ATPA_t2,
  cur_dep_w_mel = df$miniA15b_t2
)

cols_to_keep <- readLines("./data/aux/cols_to_keep.txt")
cols_to_keep <- cols_to_keep[!grepl("^#", cols_to_keep)]
df <- df[, cols_to_keep]

df$rec <- as.character(df$rec)
df$diagnosis <- as.factor(df$diagnosis)

levels(df$a03corpele_t2) <- c(
  "White", # branco
  "Black", # negro
  "Brown", # pardo
  "Indigenous", # indigena
  "Asian" # asiático
)

levels(df$a15religi_t2) <- c(
  "None", # não
  "Catholic", # Católica
  "Evangelical", # Evangélica
  "Lutheran", # Luterana
  "Spiritist", # Espírita
  "Protestant", # Protestanteq
  "Umbanda", # umbanda
  "Jewish", # Judaica
  "Jehovah's Witness", # testemunha de Jeová
  "Other" # Outra
)

levels(df$a36relaciona_t2) <- c(
  "Single", # sozinho solteiro
  "Dating", # tem namorado
  "Has partner", # tem companheiro
  "Married", # casado
  "Separated/Divorced", # separado divorciado
  "Widowed" # viuvo
)

mental_health_conditions <- c(
  "Intellectual disability", # Retardo mental
  "ADHD", # Transtornos de déficit de atenção
  "Dementia (Alzheimer, Parkinson, etc)", # Demência (Alzheimer, Parkinson, etc)
  "Substance use disorder", # Abuso ou dependência de substâncias
  "Schizophrenia and other psychotic disorders", # Esquizofrenia e outros
  "Depression", # Depressão
  "Bipolar disorder", # Transtorno bipolar
  "Anxiety disorders", # Transtornos de ansiedade
  "Sexual disorders", # Transtornos sexuais
  "Eating disorders", # Transtornos de alimentação
  "Sleep disorders", # Transtornos do sono
  "Personality disorders", # Transtornos da personalidade
  "Other behavioral disorders", # Outros transtornos comportamentais
  "Does not apply" # NSA
)
levels(df$b02doenca1_t2) <- mental_health_conditions
levels(df$b09doenca2_t2) <- mental_health_conditions

levels(df$TB_erros) <- c(
  "Unipolar depression, no hypo/mania episodes",
  "Classified as BD in MINI but not confirmed (possible diagnostic errors)",
  "Conversion to BD"
)

binary_cols <- names(df)[sapply(df, is_it_a_binary_column)]
df[binary_cols] <- lapply(df[binary_cols], fix_binary_columns)

numeric_cols <- names(df)[sapply(df, is.numeric)]
df[numeric_cols] <- lapply(
  df[numeric_cols],
  \(x) ifelse(x %in% c(99, 888, 999, 9999), NA, x)
)

saveRDS(object = df, file = "./data/processed/cleaned.rds")
