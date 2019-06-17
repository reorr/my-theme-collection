static const char norm_fg[] = "#adc6bc";
static const char norm_bg[] = "#181813";
static const char norm_border[] = "#798a83";

static const char sel_fg[] = "#adc6bc";
static const char sel_bg[] = "#5C8F6E";
static const char sel_border[] = "#adc6bc";

static const char urg_fg[] = "#adc6bc";
static const char urg_bg[] = "#38856A";
static const char urg_border[] = "#38856A";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
