const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0E0607", /* black   */
  [1] = "#624041", /* red     */
  [2] = "#704A4E", /* green   */
  [3] = "#AE384B", /* yellow  */
  [4] = "#9F5F5C", /* blue    */
  [5] = "#C27D80", /* magenta */
  [6] = "#6DCBCC", /* cyan    */
  [7] = "#e5c7c6", /* white   */

  /* 8 bright colors */
  [8]  = "#a08b8a",  /* black   */
  [9]  = "#624041",  /* red     */
  [10] = "#704A4E", /* green   */
  [11] = "#AE384B", /* yellow  */
  [12] = "#9F5F5C", /* blue    */
  [13] = "#C27D80", /* magenta */
  [14] = "#6DCBCC", /* cyan    */
  [15] = "#e5c7c6", /* white   */

  /* special colors */
  [256] = "#0E0607", /* background */
  [257] = "#e5c7c6", /* foreground */
  [258] = "#e5c7c6",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
