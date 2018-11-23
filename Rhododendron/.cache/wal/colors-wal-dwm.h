static const char norm_fg[] = "#211D33";
static const char norm_bg[] = "#fdf8fc";
static const char norm_border[] = "#948090";

static const char sel_fg[] = "#211D33";
static const char sel_bg[] = "#CF074C";
static const char sel_border[] = "#211D33";

static const char urg_fg[] = "#211D33";
static const char urg_bg[] = "#A61C4D";
static const char urg_border[] = "#A61C4D";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
