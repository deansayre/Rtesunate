#' Color Palettes
#'
#' The list of available palettes is:
#'
#' ncezid
#' niosh
#' ncrid
#' usaid
#' pmi_desert
#' pmi_bg
#' sunset
#' miami_vice
#' purple_rain
#' aladdin_sane
#' sgt_pepper
#' hello_nasty
#' ok_computer
#' los_angeles
#'
#'
#'@examples
#'
#' # Make an x-y plot using the Namatjira palette
#' library(tidyverse)
#' df <- data.frame(x = rnorm(100, 0, 20),
#'           y = rnorm(100, 0, 20),
#'           cl = sample(letters[1:8], 100, replace=TRUE))
#' ggplot(df, aes(x, y, colour=cl, shape=cl)) +
#'   geom_point(size=4) + scale_colour_ochre() +
#'   theme_bw() + theme(aspect.ratio=1)
#'
#' # Make a histogram using the McCrea Collins Street palette
#' ggplot(df, aes(x, fill=cl)) + geom_histogram() +
#'   scale_fill_ochre(palette="mccrea")
#'
#' \dontrun{
#'   data(elev)
#'   library(elevatr)
#'   library(raster)
#'   library(ochRe)
#'   colpal <- ochre_pal()(150)
#'   ex <- extent(110, 155, -45, -10)
#'   elev <- raster::crop(elev, ex)
#'   elev[elev < 0] <- NA
#'   topo <- list(x = xFromCol(elev), y = rev(yFromRow(elev)),
#'                z = t(as.matrix(elev))[, nrow(elev):1])
#'                par(mar = rep(0, 4), bg = "#444444")
#'                image(topo, useRaster = TRUE, col = colpal,
#'                      axes = FALSE, xlab = "", ylab = "",
#'                            asp = cos(27.5 * pi/180))
#' }
mal_pal <- list(
  ncezid = c("#D9531E",
             "#006A71",
             "#8B3102",
             "#8D8B00",
             "#781D7E",
             "#0033a1"),

  ncird = c("#8b9b92",
            "#532e63",
            "#7a003c",
            "#b2a97e",
            "#ffe293",
            "#0033a1"),

  niosh = c("#695e4a",
            "#8b0e04",
            "#26bcd7",
            "#7ac143",
            "#f89728",
            "#0033a1"),

usaid = c("#002F6C",
          "#0067B9",
          "#A7C6ED",
          "#BA0C2F",
          "#6C6463",
          "#CFCDC9"),


pmi_desert = c("#002F6C",
               "#1C5789",
               "#E17888",
               "#AE3B8B",
               "#341514"),

pmi_bg = c("#002F6C",
           "#1C5789",
           "#395e66",
           "#387d7a",
           "#32936f",
           "#26a96c",
           "#2bc016"),

sunset = c("#3A6D80",
           "#144058",
           "#4D181C",
           "#9D402D",
           "#DD671E",
           "#E58D2E",
           "#F3CD53"),

miami_vice = c("#802621",
               "#E3856B",
               "#E9B796",
               "#EEC95C",
               "#B8912E",
               "#57BBBC",
               "#CEE6F2",
               "#EECCD3",
               "#B6818B"),

# prince: purple rain, 1984
purple_rain = c("#231A21",
                "#67329F",
                "#4D343F",
                "#6D7296",
                "#605965",
                "#6C233B",
                "#9C6558",
                "#D3C5B6"),

# david bowie: aladdin sane, 1973
aladdin_sane = c("#2B161A",
                 "#7E3930",
                 "#C53949",
                 "#B35C64",
                 "#CAB9C8",
                 "#4C6683"),

# the beatles: sgt. pepper's lonely hearts club band, 1967
sgt_pepper = c("#EFE03F",
               "#DD0F85",
               "#4BD4F4",
               "#EB5F40",
               "#C43946",
               "#584060",
               "#473B37",
               "#B09472",
               "#B9CAC9"),

# beastie boys: hello nasty, 1998
hello_nasty = c("#DB5721",
                "#E7C146",
                "#EFDD56",
                "#E4DA9F",
                "#A4A299",
                "#66665D",
                "#222220"),

# radiohead: ok computer, 1997
ok_computer = c("#00447c",
                "#eaf3f5",
                "#aed1e0",
                "#9ab9c8",
                "#4b5661",
                "#8d747c",
                "#c9b3b3"),

 # joy division: unknown pleasures, 1979
unknown_pleasures = c("#11120d",
                      "#dfdfd7"),

 # x: los angeles, 1980
los_angeles = c("#001121",
                "#fffed8",
                "#58130c",
                "#fb3320",
                "#bfbfbf"))

usethis::use_data(mal_pal, overwrite = TRUE)

#
#    "#CF9032", "#CD7E2A", "#6C3622", "#6FA1BB"
#
#    "#507B6A", "#6A513C", "#A4998E", "#4B1816"
#
#
#
#    "#678CEC", "#D49BAE", "#BBCB50"
#
#    "#4AAFD5", "#91B187", "#E7A339"
#
#
#
#
#
#
