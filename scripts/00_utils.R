# NOTE: In case the patient did not convert to BD, it should have one of the
# depressive episodes (classical episode, atypical episode or episode with
# melancholic features), otherwise it presented no current mood episode when
# reassessed. The tests for NA are needed given the encoding of the dataset.
make_diagnosis <- function(bd, cur_dep, cur_atp_dep, cur_dep_w_mel) {
  ifelse(
    !is.na(bd) & bd == "conversão para TB",
    "Bipolar disorder",
    ifelse(
      (!is.na(cur_dep) & cur_dep == 1) |
        (!is.na(cur_atp_dep) & cur_atp_dep == 1) |
        (!is.na(cur_dep_w_mel) & cur_dep_w_mel == 1),
      "Current depressive episode",
      "No mood episode at follow-up"
    )
  )
}


recode_bdi_item <- function(answer) {
  switch(
    as.character(answer),
    "0" = 0,
    "1" = 1,
    "2" = 1,
    "3" = 2,
    "4" = 2,
    "5" = 3,
    "6" = 3,
    NA
  )
}


is_it_a_binary_column <- function(column) {
  combinations <- list(
    c("0", "1", "8"),
    c("0", "1"),
    c("não", "sim", "8"),
    c("não", "sim")
  )

  processed_column <- unique(tolower(na.omit(column)))

  for (comb in combinations) {
    if (setequal(processed_column, comb)) {
      return(TRUE)
    }
  }
  FALSE
}


fix_binary_columns <- function(column) {
  yes_options <- c("sim", "yes", "1")
  no_options <- c("não", "no", "0")
  lowered <- tolower(column)

  if ("8" %in% unique(column)) {
    as.factor(ifelse(
      lowered %in% no_options,
      "No",
      ifelse(
        lowered %in% yes_options,
        "Yes",
        ifelse(
          lowered == "8",
          "Don't know",
          NA_character_
        )
      )
    ))
  } else {
    as.factor(ifelse(lowered %in% no_options, "No", "Yes"))
  }
}
