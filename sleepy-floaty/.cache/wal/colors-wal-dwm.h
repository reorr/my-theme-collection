static const char norm_fg[] = "#383B44";
static const char norm_bg[] = "#fefcfb";
static const char norm_border[] = "#978e8b";

static const char sel_fg[] = "#383B44";
static const char sel_bg[] = "#8F9AAC";
static const char sel_border[] = "#383B44";

static const char urg_fg[] = "#383B44";
static const char urg_bg[] = "#7C91C3";
static const char urg_border[] = "#7C91C3";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
