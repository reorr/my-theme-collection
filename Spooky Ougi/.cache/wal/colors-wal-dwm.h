static const char norm_fg[] = "#e5c7c6";
static const char norm_bg[] = "#0E0607";
static const char norm_border[] = "#a08b8a";

static const char sel_fg[] = "#e5c7c6";
static const char sel_bg[] = "#704A4E";
static const char sel_border[] = "#e5c7c6";

static const char urg_fg[] = "#e5c7c6";
static const char urg_bg[] = "#624041";
static const char urg_border[] = "#624041";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
