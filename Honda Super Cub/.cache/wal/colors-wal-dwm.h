static const char norm_fg[] = "#c0c0bd";
static const char norm_bg[] = "#282528";
static const char norm_border[] = "#868684";

static const char sel_fg[] = "#c0c0bd";
static const char sel_bg[] = "#B66846";
static const char sel_border[] = "#c0c0bd";

static const char urg_fg[] = "#c0c0bd";
static const char urg_bg[] = "#8F6D54";
static const char urg_border[] = "#8F6D54";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
