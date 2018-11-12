const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#282528", /* black   */
  [1] = "#8F6D54", /* red     */
  [2] = "#B66846", /* green   */
  [3] = "#B89144", /* yellow  */
  [4] = "#A18965", /* blue    */
  [5] = "#CBA664", /* magenta */
  [6] = "#798188", /* cyan    */
  [7] = "#c0c0bd", /* white   */

  /* 8 bright colors */
  [8]  = "#868684",  /* black   */
  [9]  = "#8F6D54",  /* red     */
  [10] = "#B66846", /* green   */
  [11] = "#B89144", /* yellow  */
  [12] = "#A18965", /* blue    */
  [13] = "#CBA664", /* magenta */
  [14] = "#798188", /* cyan    */
  [15] = "#c0c0bd", /* white   */

  /* special colors */
  [256] = "#282528", /* background */
  [257] = "#c0c0bd", /* foreground */
  [258] = "#c0c0bd",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
